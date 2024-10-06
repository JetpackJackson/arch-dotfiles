# lisgd

Lisgd (libinput **synthetic** gesture daemon) lets you bind gestures based on
libinput touch events to run specific commands to execute. For example,
dragging left to right with one finger could execute a particular command
like launching a terminal. Directional L-R, R-L, U-D, and D-U gestures and
diagnol LD-RU, RD-LU, UR-DL, UL-DR gestures are supported with 1 through
n fingers.

Unlike other libinput gesture daemons, lisgd uses touch events to
recognize **synthetic swipe gestures** rather than using the *libinput*'s
gesture events. The advantage of this is that the synthetic gestures
you define via lisgd can be used on touchscreens, which normal libinput
gestures don't support.

This program was built for use on the [Pinephone](https://www.pine64.org/pinephone/);
however it could be used in general for any device that supports touch events,
like laptop touchscreens or similar. You may want to adjust the threshold
depending on the device you're using.

## Configuration

Configuration can be done in two ways:

1. Through a suckless style `config.h`; see the `config.def.h`
2. Through commandline flags which override the default config.h values

### Suckless-style config.h based configuration

Copy the example `config.def.h` configuration to `config.h`.

### Commandline flags based configuration

Flags:

- **-d [devicenodepath]**: Defines the dev filesystem device to monitor
  - Example: `lisgd -d /dev/input/input1`
- **-g [nfingers,gesture,edge,distance,actmode,command]**: Allows you to bind a gesture wherein nfingers is an integer, gesture is
one of {LR,RL,DU,UD,DLUR,URDL,ULDR,DLUR}, edge is one of * (any), N (none), L (left), R (right), T (top), B (bottom), TL (top left), TR (top right), BL (bottom left), BR (bottom right) and distance is one of * (any), S (short), M (medium), L (large). actmode is R (release) for normal mode and P (pressed) for pressed mode (but this field may be omitted entirely for backward
compatibility), command is the shell command to be executed. The -g option can be used
  multiple times to bind multiple gestures.
  - Single Gesture Example: `lisgd -g "1,LR,*,*,R,notify-send swiped lr"`
  - Multiple Gestures Example: `lisgd -g "1,LR,*,*,R,notify-send swiped lr" -g "1,RL,R,*,R,notify-send swiped rl from right edge"`
- **-m [timeoutms]**: Number of milliseconds gestures must be performed within
    to be registered. After the timeoutms value; the gesture won't be registered.
  - Example: `lisgd -m 1200`
- **-o [orientation]**: Number of 90-degree rotations to translate gestures by.
  Can be set to 0-3. For example using 1; a L-R gesture would become a U-D
  gesture. Meant to be used for screen-rotation.
  - Example `lisgd -o 1`
- **-r [degrees]**: Number of degrees offset each 45-degree interval may still
  be recognized within. Maximum value is 45. Default value is 15. E.g. U-D
  is a 180 degree gesture but with 15 degrees of leniency will be recognized
  between 165-195 degrees.
  - Example: `lisgd -r 20`
- **-t [threshold_units]**: Threshold in libinput units (pixels) after which a
  gesture registers. Defaults to 125.
  - Example: `lisgd -t 125`
- **-T [threshold_units]**: Threshold in libinput units (pixels) after which a
  gesture registers for 'pressed' gestures where fingers are not lifted.
  Defaults to 60.
  - Example: `lisgd -t 60`
- **-w [screenwidth]**: Width of screen used for edge-based gestures. Use in
  conjunction with -h. If unset dynamic X/Wayland screen geometry detection is
  used.
  - Example: `lisgd -w 600`
- **-h [screenheight]**: Height of screen used for edge-based gestures. Use in
  conjunction with -w. If unset dynamic X/Wayland screen geometry detection is
  used.
  - Example: `lisgd -h 500`
- **-v**: Verbose mode, useful for debugging
  - Example: `lisgd -v`
