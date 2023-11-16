function birthday --wraps='ls -alct --full-time / | tail -1 | tr : ' --wraps='ls -alct --full-time / | tail -1' --description 'alias birthday=ls -alct --full-time / | tail -1'
  ls -alct --full-time / | tail -1 $argv
        
end
