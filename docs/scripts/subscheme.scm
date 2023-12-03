(import
  (scheme base)
  (scheme read)
  (scheme write)
  (scheme eval)
  (scheme process-context)
  (srfi 1)
  (srfi 26))

(define env (interaction-environment))

(define (read-from-string str)
  (call-with-port (open-input-string str) read))

(define (read-all-from-string str)
  (define port (open-input-string str))
  (unfold
    eof-object?
    (lambda (x) x)
    (lambda (x) (read port))
    (read port)
    (lambda (x) (close-port port) (list))))

(define (get-args opts start)
  (if (> (string-length (car opts)) start)
    (cons (string-copy (car opts) start) (cdr opts))
    (cdr opts)))

(define (process-opts opts)
  (if (and (not (null? opts)) (char=? (string-ref (car opts) 0) #\-) (not (string=? (car opts) "--")))
    (process-opts
      (case (string-ref (car opts) 1)
        ((#\d)
         (let ((args (get-args opts 2)))
           (eval (list 'define (string->symbol (car args)) (read-from-string (cadr args))) env)
           (cddr args)))
        ((#\s)
         (let ((args (get-args opts 2)))
           (eval (list 'define (string->symbol (car args)) (cadr args)) env)
           (cddr args)))
        ((#\D)
         (let ((args (get-args opts 2)))
           (eval (list 'define (string->symbol (car args)) (cons 'list (read-all-from-string (cadr args)))) env)
           (cddr args)))
        ((#\S)
         (let* ((args (get-args opts 2))
                (len (list-index (lambda (x) (string=? x (cadr args))) (cddr args))))
           (eval (list 'define (string->symbol (car args)) (cons 'list (take (cddr args) len))) env)
           (drop (cdddr args) len)))))))

(process-opts (cdr (command-line)))

(do ((c (peek-char) (peek-char))) ((eof-object? c))
  (case c
    ((#\|) (display (eval (read) env)))
    ((#\() (eval (read) env))
    (else (write-char (read-char)))))
