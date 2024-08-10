function launch-plasma-x11 --description 'plasma X11'
    set -gx DESKTOP_SESSION plasma
    startx /usr/bin/startplasma-x11
end
