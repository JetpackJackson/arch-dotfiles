/*
  distancethreshold: Minimum cutoff for a gestures to take effect
  degreesleniency: Offset degrees within which gesture is recognized (max=45)
  timeoutms: Maximum duration for a gesture to take place in miliseconds
  orientation: Number of 90 degree turns to shift gestures by
  verbose: 1=enabled, 0=disabled; helpful for debugging
  device: Path to the /dev/ filesystem device events should be read from
  gestures: Array of gestures; binds num of fingers / gesturetypes to commands
            Supported gestures: SwipeLR, SwipeRL, SwipeDU, SwipeUD,
                                SwipeDLUR, SwipeURDL, SwipeDRUL, SwipeULDR
*/

unsigned int distancethreshold = 125;
unsigned int distancethreshold_pressed = 60;
unsigned int degreesleniency = 15;
unsigned int timeoutms = 800;
unsigned int orientation = 0;
unsigned int verbose = 0;
double edgesizeleft = 50.0;
double edgesizetop = 50.0;
double edgesizeright = 50.0;
double edgesizebottom = 50.0;
double edgessizecaling = 1.0;
//char *device = "/dev/input/touchscreen";
char *device = "/dev/input/by-path/pci-0000:00:15.0-platform-i2c_designware.0-event";

//Gestures can also be specified interactively from the command line using -g
Gesture gestures[] = {
	/* nfingers  gesturetype  command */
	//{ 1,         SwipeLR,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg workspace prev" },
	//{ 1,         SwipeRL,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg workspace next" },
	//{ 1,         SwipeDLUR,   EdgeAny, DistanceAny, ActModeReleased, "sxmo_vol.sh up" },
	//{ 1,         SwipeURDL,   EdgeAny, DistanceAny, ActModeReleased, "sxmo_vol.sh down" },
	{ 2,         SwipeLR,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg workspace next"},
	{ 2,         SwipeRL,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg workspace prev"},
	{ 2,         SwipeDRUL,   EdgeAny, DistanceAny, ActModeReleased, "pactl set-sink-volume @DEFAULT_SINK@ +10%" },
	{ 2,         SwipeULDR,   EdgeAny, DistanceAny, ActModeReleased, "pactl set-sink-volume @DEFAULT_SINK@ -10%" },
	{ 2,         SwipeDU,     EdgeAny, DistanceAny, ActModeReleased, "squeekboard &" },
	{ 2,         SwipeUD,     EdgeAny, DistanceAny, ActModeReleased, "killall squeekboard" },
	//{ 2,         SwipeDU,     EdgeAny, DistanceAny, ActModeReleased, "pidof $KEYBOARD || $KEYBOARD &" },
	//{ 2,         SwipeUD,     EdgeAny, DistanceAny, ActModeReleased, "pkill -9 -f $KEYBOARD" },
	{ 3,         SwipeLR,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg layout tabbed" },
	{ 3,         SwipeRL,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg layout stacking" },
	{ 3,         SwipeUD,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg layout toggle split" },
	{ 3,         SwipeDU,     EdgeAny, DistanceAny, ActModeReleased, "nwg-drawer" },
	{ 3,         SwipeDRUL,   EdgeAny, DistanceAny, ActModeReleased, "(grim -g \"$(slurp)\" - | swappy -f - -o - | tee ~/pics/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy) &" },
	{ 3,         SwipeURDL,   EdgeAny, DistanceAny, ActModeReleased, "(grim - | swappy -f - -o - | tee ~/pics/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy) &" },
	{ 4,         SwipeDU,     EdgeAny, DistanceAny, ActModeReleased, "pactl set-sink-volume @DEFAULT_SINK@ 0%" },
	{ 4,         SwipeUD,     EdgeAny, DistanceAny, ActModeReleased, "swaymsg kill" },

};
