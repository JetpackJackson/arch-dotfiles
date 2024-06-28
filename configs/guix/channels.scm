(cons (channel
    (name 'pita-packs)
    (url "https://codeberg.org/JetpackJackson/guix-pita-packs.git")
    (branch "main")
    (introduction
     (make-channel-introduction
      "2970fc386422ec7d87aa7ced47f271191e3e534f"
      (openpgp-fingerprint
       "3B7F DB3E E2B6 9E38 B92F  E634 1E3B 936F 5D63 4C6C"))))
;  (channel
;        (name 'guix)
;        (url "https://git.savannah.gnu.org/git/guix.git")
;        (branch "master")
;        (introduction
;          (make-channel-introduction
;            "9edb3f66fd807b096b48283debdcddccfea34bad"
;            (openpgp-fingerprint
;              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
  %default-channels)
