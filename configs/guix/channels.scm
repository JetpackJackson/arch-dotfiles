; https://guix.gnu.org/manual/en/html_node/Channels-with-Substitutes.html
(use-modules (guix ci))

(list (channel-with-substitutes-available
       %default-guix-channel
       "https://ci.guix.gnu.org"))
