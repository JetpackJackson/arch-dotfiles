#include <errno.h>
#include <fcntl.h>
#include <libinput.h>
#include <math.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/select.h>
#include <time.h>
#include <unistd.h>
#ifdef WITH_X11
# include <X11/Xlib.h>
#endif
#ifdef WITH_WAYLAND
# include <wayland-client.h>
#endif

/* Defines */
#define MAXSLOTS 20
#define NOMOTION -999999

/* Types */
enum {
  SwipeDU,
  SwipeUD,
  SwipeLR,
  SwipeRL,
  SwipeDLUR,
  SwipeDRUL,
  SwipeURDL,
  SwipeULDR
};
typedef int Swipe;

enum {
	EdgeAny,
	EdgeNone,
	EdgeLeft,
	EdgeRight,
	EdgeTop,
	EdgeBottom,
	CornerTopLeft,
	CornerTopRight,
	CornerBottomLeft,
	CornerBottomRight,
};
typedef int Edge;

enum {
	DistanceAny,
	DistanceShort,
	DistanceMedium,
	DistanceLong,
};
typedef int Distance;

enum {
	ActModeReleased, //action triggers when fingers are released
	ActModePressed, //action triggers while finger is not lifted yet (as soon as a swipe is completed)
};
typedef int ActMode;

typedef struct {
	int nfswipe;
	Swipe swipe;
	Edge edge;
	Distance distance;
	ActMode actmode;
	char *command;
} Gesture;

/* Config */
#include "config.h"

/* Globals */
Gesture *gestsarr;
int gestsarrlen;
int have_actmode_pressed = 0; //do we have gestures using actmode pressed?
Swipe pendingswipe;
Edge pendingedge;
Distance pendingdistance;
double xstart[MAXSLOTS], xend[MAXSLOTS], ystart[MAXSLOTS], yend[MAXSLOTS];
unsigned nfdown = 0, nfpendingswipe = 0;
struct timespec timedown;
static int screen;
#ifdef WITH_WAYLAND
struct wl_display *wl_display;
struct wl_registry *wl_registry;
struct wl_output *wl_output;
#endif
static int screenwidth = 0, screenheight = 0;

void
die(char * msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

int
gesturecalculateswipewithindegrees(double gestdegrees, double wantdegrees) {
	return (
		gestdegrees >= wantdegrees - degreesleniency &&
		gestdegrees <= wantdegrees + degreesleniency
	);
}

Swipe
gesturecalculateswipe(double x0, double y0, double x1, double y1, int mindistance) {
	double t, degrees, dist;

	t = atan2(x1 - x0, y0 - y1);
	degrees = 57.2957795130823209 * (t < 0 ? t + 6.2831853071795865 : t);
	dist = sqrt(pow(x1 - x0, 2) + pow(y1 - y0, 2));

	if (verbose)
		fprintf(stderr, "Swipe distance=[%.2f]; degrees=[%.2f]\n", dist, degrees);

	if (dist < mindistance) return -1;
	else if (gesturecalculateswipewithindegrees(degrees, 0))   return SwipeDU;
	else if (gesturecalculateswipewithindegrees(degrees, 45))  return SwipeDLUR;
	else if (gesturecalculateswipewithindegrees(degrees, 90))  return SwipeLR;
	else if (gesturecalculateswipewithindegrees(degrees, 135)) return SwipeULDR;
	else if (gesturecalculateswipewithindegrees(degrees, 180)) return SwipeUD;
	else if (gesturecalculateswipewithindegrees(degrees, 225)) return SwipeURDL;
	else if (gesturecalculateswipewithindegrees(degrees, 270)) return SwipeRL;
	else if (gesturecalculateswipewithindegrees(degrees, 315)) return SwipeDRUL;
	else if (gesturecalculateswipewithindegrees(degrees, 360)) return SwipeDU;

	return -1;
}

Distance
gesturecalculatedistance(double x0, double y0, double x1, double y1, Swipe swipe) {
	double dist = sqrt(pow(x1 - x0, 2) + pow(y1 - y0, 2));
	double diag = sqrt(pow(screenwidth,2) + pow(screenheight,2));
	switch (swipe) {
		case SwipeDU:
		case SwipeUD:
			if (dist >= screenheight * 0.66) {
				return DistanceLong;
			} else if (dist >= screenheight * 0.33) {
				return DistanceMedium;
			} else {
				return DistanceShort;
			}
			break;
		case SwipeLR:
		case SwipeRL:
			if (dist >= screenwidth * 0.66) {
				return DistanceLong;
			} else if (dist >= screenwidth * 0.33) {
				return DistanceMedium;
			} else {
				return DistanceShort;
			}
			break;
		case SwipeULDR:
		case SwipeDRUL:
		case SwipeDLUR:
		case SwipeURDL:
			if (dist >= diag * 0.66) {
				return DistanceLong;
			} else if (dist >= diag * 0.33) {
				return DistanceMedium;
			} else {
				return DistanceShort;
			}
			break;
	}

	return 0; //shouldn't happen
}

Edge
gesturecalculateedge(double x0, double y0, double x1, double y1) {
		Edge horizontal = EdgeNone;
		Edge vertical = EdgeNone;
		if (x0 <= edgesizeleft * edgessizecaling) {
			horizontal = EdgeLeft;
		} else if (x0 >= screenwidth - edgesizeright * edgessizecaling) {
			horizontal = EdgeRight;
		} else if (x1 <= edgesizeleft * edgessizecaling) {
			horizontal = EdgeLeft;
		} else if (x1 >= screenwidth - edgesizeright * edgessizecaling) {
			horizontal = EdgeRight;
		}
		if (y0 <= edgesizetop * edgessizecaling) {
			vertical = EdgeTop;
		} else if (y0 >= screenheight - edgesizebottom * edgessizecaling) {
			vertical = EdgeBottom;
		} else if (y1 <= edgesizetop * edgessizecaling) {
			vertical = EdgeTop;
		} else if (y1 >= screenheight - edgesizebottom * edgessizecaling) {
			vertical = EdgeBottom;
		}
		if (horizontal == EdgeLeft && vertical == EdgeTop) {
			return CornerTopLeft;
		} else if (horizontal == EdgeRight && vertical == EdgeTop) {
			return CornerTopRight;
		} else if (horizontal == EdgeLeft && vertical == EdgeBottom) {
			return CornerBottomLeft;
		} else if (horizontal == EdgeRight && vertical == EdgeBottom) {
			return CornerBottomRight;
		} else if (horizontal != EdgeNone) {
			return horizontal;
		} else {
			return vertical;
		}
}

int
gestureexecute(Swipe swipe, int nfingers, Edge edge, Distance distance, ActMode actmode) {
	int i;

	for (i = 0; i < gestsarrlen; i++) {
		if (verbose) {
			fprintf(stderr,
				"[swipe]: Cfg(f=%d/s=%d/e=%d/d=%d) <=> Evt(f=%d/s=%d/e=%d/d=%d)\n",
				gestsarr[i].nfswipe, gestsarr[i].swipe, gestsarr[i].edge, gestsarr[i].distance, nfingers, swipe, edge, distance
			);
		}
		if (gestsarr[i].nfswipe == nfingers && gestsarr[i].swipe == swipe
			&& gestsarr[i].distance <= distance
			&& (gestsarr[i].edge == EdgeAny || gestsarr[i].edge == edge ||
				((edge == CornerTopLeft || edge == CornerTopRight) && gestsarr[i].edge == EdgeTop) ||
				((edge == CornerBottomLeft || edge == CornerBottomRight) && gestsarr[i].edge == EdgeBottom) ||
				((edge == CornerTopLeft || edge == CornerBottomLeft) && gestsarr[i].edge == EdgeLeft) ||
				((edge == CornerTopRight || edge == CornerBottomRight) && gestsarr[i].edge == EdgeRight)
			   )
			&& (actmode == ActModeReleased || gestsarr[i].actmode == actmode)
			) {
			if (verbose) fprintf(stderr, "Execute %s\n", gestsarr[i].command);
			system(gestsarr[i].command);
			return 1; //execute first match only
		}
	}
	return 0;
}

static int
libinputopenrestricted(const char *path, int flags, void *user_data)
{
	int fd = open(path, flags);
	return fd < 0 ? -errno : fd;
}

static void
libinputcloserestricted(int fd, void *user_data)
{
	close(fd);
}

Swipe
swipereorient(Swipe swipe, int orientation) {
	while (orientation > 0) {
		switch(swipe) {
			// 90deg per turn so: L->U, R->D, U->R, D->L
			case SwipeDU:   swipe = SwipeLR; break;
			case SwipeDLUR: swipe = SwipeULDR; break;
			case SwipeLR:   swipe = SwipeUD; break;
			case SwipeULDR: swipe = SwipeURDL; break;
			case SwipeUD:   swipe = SwipeRL; break;
			case SwipeURDL: swipe = SwipeDRUL; break;
			case SwipeRL:   swipe = SwipeDU; break;
			case SwipeDRUL: swipe = SwipeDLUR; break;
		}
		orientation--;
	}
	return swipe;
}

Edge
edgereorient(Edge edge, int orientation) {
	while (orientation > 0) {
		switch(edge) {
			// 90deg per turn
			case EdgeLeft:   edge = EdgeTop; break;
			case EdgeRight:  edge = EdgeBottom; break;
			case EdgeTop:    edge = EdgeRight; break;
			case EdgeBottom: edge = EdgeLeft; break;
			case CornerTopLeft: edge = CornerTopRight; break;
			case CornerTopRight:   edge = CornerBottomRight; break;
			case CornerBottomLeft: edge = CornerTopLeft; break;
			case CornerBottomRight: edge = CornerBottomLeft; break;
		}
		orientation--;
	}
	return edge;
}

void
touchdown(struct libinput_event *e)
{
	struct libinput_event_touch *tevent;
	int slot;

	tevent = libinput_event_get_touch_event(e);
	slot = libinput_event_touch_get_slot(tevent);
	xstart[slot] = libinput_event_touch_get_x_transformed(tevent, screenwidth);
	ystart[slot] = libinput_event_touch_get_y_transformed(tevent, screenheight);
	if (nfdown == 0) clock_gettime(CLOCK_MONOTONIC_RAW, &timedown);
	nfdown++;
}

void
resetslot(int slot) {
	xend[slot] = NOMOTION;
	yend[slot] = NOMOTION;
	xstart[slot] = NOMOTION;
	ystart[slot] = NOMOTION;
}


void
touchmotion(struct libinput_event *e)
{
	struct libinput_event_touch *tevent;
	struct timespec now;
	int slot;

	tevent = libinput_event_get_touch_event(e);
	slot = libinput_event_touch_get_slot(tevent);
	xend[slot] = libinput_event_touch_get_x_transformed(tevent, screenwidth);
	yend[slot] = libinput_event_touch_get_y_transformed(tevent, screenheight);

	if (have_actmode_pressed) {
		Swipe swipe = gesturecalculateswipe(
			xstart[slot], ystart[slot], xend[slot], yend[slot], distancethreshold_pressed
		);
		if (swipe != -1) {
			Edge edge = gesturecalculateedge(
				xstart[slot], ystart[slot], xend[slot], yend[slot]
			);
			clock_gettime(CLOCK_MONOTONIC_RAW, &now);
			if (
				timeoutms >
				((now.tv_sec - timedown.tv_sec) * 1000000 + (now.tv_nsec - timedown.tv_nsec) / 1000) / 1000
			) {
				if (verbose) fprintf(stderr, "(Attempting to find matching pressed gesture)\n");
				if (gestureexecute(swipe, nfdown, edge, DistanceAny, ActModePressed)) {
					//we found and executed a matching gesture, reset the slot
					if (verbose) fprintf(stderr, "(Pressed gestured Executed)\n");
					xstart[slot] = xend[slot];
					ystart[slot] = yend[slot];
					timedown = now;
				}
			}
		}
	}
}

void
touchup(struct libinput_event *e)
{
	int slot;
	struct libinput_event_touch *tevent;
	struct timespec now;

	tevent = libinput_event_get_touch_event(e);
	slot = libinput_event_touch_get_slot(tevent);
	nfdown--;
	clock_gettime(CLOCK_MONOTONIC_RAW, &now);

	// E.g. invalid motion, it didn't begin/end from anywhere
	if (
		xstart[slot] == NOMOTION || ystart[slot] == NOMOTION ||
		xend[slot] == NOMOTION || yend[slot] == NOMOTION
	) return;

	Swipe swipe = gesturecalculateswipe(
		xstart[slot], ystart[slot], xend[slot], yend[slot], distancethreshold
	);
	Edge edge = gesturecalculateedge(
		xstart[slot], ystart[slot], xend[slot], yend[slot]
	);
	Distance distance = gesturecalculatedistance(
		xstart[slot], ystart[slot], xend[slot], yend[slot], swipe
	);
	if (nfpendingswipe == 0) {
		pendingswipe = swipe;
		pendingedge = edge;
		pendingdistance = distance;
	}
	if (pendingswipe == swipe) nfpendingswipe++;
	resetslot(slot);

	// All fingers up - check if within millisecond limit, exec, & reset
	if (nfdown == 0) {
		if (
			timeoutms >
			((now.tv_sec - timedown.tv_sec) * 1000000 + (now.tv_nsec - timedown.tv_nsec) / 1000) / 1000
		) gestureexecute(swipe, nfpendingswipe, edge, distance, ActModeReleased);

		nfpendingswipe = 0;
	}
}

void
run(void)
{
	int i;
	struct libinput *li;
	struct libinput_event *event;
	struct libinput_device *d;
	int selectresult;
	fd_set fdset;

	const static struct libinput_interface interface = {
		.open_restricted = libinputopenrestricted,
		.close_restricted = libinputcloserestricted,
	};

	if ((li = libinput_path_create_context(&interface, NULL)) == NULL)
		die("Failed to initialize context");

	if ((d = libinput_path_add_device(li, device)) == NULL) {
		die("Couldn't bind event from dev filesystem");
	} else if (LIBINPUT_CONFIG_STATUS_SUCCESS != libinput_device_config_send_events_set_mode(
		d, LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
	)) {
		die("Couldn't set mode to capture events");
	}

	// E.g. initially invalidate every slot
	for (i = 0; i < MAXSLOTS; i++) {
		xend[i] = NOMOTION;
		yend[i] = NOMOTION;
		xstart[i] = NOMOTION;
		ystart[i] = NOMOTION;
	}

	FD_ZERO(&fdset);
	FD_SET(libinput_get_fd(li), &fdset);
	for (;;) {
		selectresult = select(FD_SETSIZE, &fdset, NULL, NULL, NULL);
		if (selectresult == -1) {
			die("Can't select on device node?");
		} else {
			libinput_dispatch(li);
			while ((event = libinput_get_event(li)) != NULL) {
				switch(libinput_event_get_type(event)) {
					case LIBINPUT_EVENT_TOUCH_DOWN: touchdown(event); break;
					case LIBINPUT_EVENT_TOUCH_UP: touchup(event); break;
					case LIBINPUT_EVENT_TOUCH_MOTION: touchmotion(event); break;
				}
				libinput_event_destroy(event);
			}
		}
	}
	libinput_unref(li);
}

#ifdef WITH_WAYLAND
static void
display_handle_geometry(void *data, struct wl_output *wl_output, int x, int y, int physical_width, int physical_height, int subpixel, const char *make, const char *model, int transform)
{
	orientation = transform;
	if (orientation == 1) {
		orientation = 3;
	} else if (orientation == 3) {
		orientation = 1;
	}
}

static void
display_handle_done(void *data, struct wl_output *wl_output)
{
}

static void
display_handle_scale(void *data, struct wl_output *wl_output, int32_t scale)
{
}

static void
display_handle_mode(void *data, struct wl_output *wl_output, uint32_t flags, int width, int height, int refresh)
{
	screenwidth = width;
	screenheight = height;
}

static const struct wl_output_listener output_listener = {
	.geometry = display_handle_geometry,
	.mode = display_handle_mode,
	.done = display_handle_done,
	.scale = display_handle_scale
};

static void
registry_global(void *data, struct wl_registry *wl_registry,
		uint32_t name, const char *interface, uint32_t version)
{
	if (strcmp(interface, "wl_output") == 0) {
		if (!wl_output) {
			wl_output = wl_registry_bind(wl_registry, name, &wl_output_interface, 3);
			wl_output_add_listener(wl_output, &output_listener, NULL);
		}
	};
}

static void
registry_global_remove(void *data,
		struct wl_registry *wl_registry, uint32_t name)
{
}

static const struct
wl_registry_listener wl_registry_listener = {
	.global = registry_global,
	.global_remove = registry_global_remove,
};
#endif

int
main(int argc, char *argv[])
{
	int i, j;
	char *gestpt;

	gestsarr = NULL;
	gestsarrlen = 0;

	prctl(PR_SET_PDEATHSIG, SIGTERM);
	prctl(PR_SET_PDEATHSIG, SIGKILL);

	for (i = 1; i < argc; i++) {
		if (!strcmp(argv[i], "-v")) {
			verbose = 1;
		} else if (!strcmp(argv[i], "-d")) {
			if (i == argc - 1) die("option -d expects a value");
			device = argv[++i];
		} else if (!strcmp(argv[i], "-t")) {
			if (i == argc - 1) die("option -t expects a value");
			distancethreshold = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "-T")) {
			if (i == argc - 1) die("option -T expects a value");
			distancethreshold_pressed = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "-r")) {
			if (i == argc - 1) die("option -r expects a value");
			degreesleniency = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "-m")) {
			if (i == argc - 1) die("option -m expects a value");
			timeoutms = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "-o")) {
			if (i == argc - 1) die("option -o expects a value");
			orientation = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "-h")) {
			if (i == argc - 1) die("option -h expects a value");
			screenheight = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "-w")) {
			if (i == argc - 1) die("option -w expects a value");
			screenwidth = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "-s")) {
			if (i == argc - 1) die("option -s expects a value");
			edgessizecaling = atof(argv[++i]);
		} else if (!strcmp(argv[i], "-g")) {
			if (i == argc - 1) die("option -g expects a value");
			gestsarrlen++;
			gestsarr = realloc(gestsarr, (gestsarrlen * sizeof(Gesture)));
			if (gestsarr == NULL) {
				perror("Could not allocate memory");
				exit(EXIT_FAILURE);
			}
			gestpt = strtok(argv[++i], ",");
			for (j = 0; gestpt != NULL && j < 6; gestpt = strtok(NULL, ","), j++) {
				switch(j) {
					case 0: gestsarr[gestsarrlen - 1].nfswipe = atoi(gestpt); break;
					case 1:
						if (!strcmp(gestpt, "LR")) gestsarr[gestsarrlen-1].swipe = SwipeLR;
						if (!strcmp(gestpt, "RL")) gestsarr[gestsarrlen-1].swipe = SwipeRL;
						if (!strcmp(gestpt, "DU")) gestsarr[gestsarrlen-1].swipe = SwipeDU;
						if (!strcmp(gestpt, "UD")) gestsarr[gestsarrlen-1].swipe = SwipeUD;
						if (!strcmp(gestpt, "DLUR")) gestsarr[gestsarrlen-1].swipe = SwipeDLUR;
						if (!strcmp(gestpt, "URDL")) gestsarr[gestsarrlen-1].swipe = SwipeURDL;
						if (!strcmp(gestpt, "ULDR")) gestsarr[gestsarrlen-1].swipe = SwipeULDR;
						if (!strcmp(gestpt, "DRUL")) gestsarr[gestsarrlen-1].swipe = SwipeDRUL;
						break;
					case 2:
						if (!strcmp(gestpt, "L")) gestsarr[gestsarrlen-1].edge = EdgeLeft;
						if (!strcmp(gestpt, "R")) gestsarr[gestsarrlen-1].edge = EdgeRight;
						if (!strcmp(gestpt, "T")) gestsarr[gestsarrlen-1].edge = EdgeTop;
						if (!strcmp(gestpt, "B")) gestsarr[gestsarrlen-1].edge = EdgeBottom;
						if (!strcmp(gestpt, "TL")) gestsarr[gestsarrlen-1].edge = CornerTopLeft;
						if (!strcmp(gestpt, "TR")) gestsarr[gestsarrlen-1].edge = CornerTopRight;
						if (!strcmp(gestpt, "BL")) gestsarr[gestsarrlen-1].edge = CornerBottomLeft;
						if (!strcmp(gestpt, "BR")) gestsarr[gestsarrlen-1].edge = CornerBottomRight;
						if (!strcmp(gestpt, "N")) gestsarr[gestsarrlen-1].edge = EdgeNone;
						if (!strcmp(gestpt, "*")) gestsarr[gestsarrlen-1].edge = EdgeAny;
						break;
					case 3:
						if (!strcmp(gestpt, "L")) gestsarr[gestsarrlen-1].distance = DistanceLong;
						if (!strcmp(gestpt, "M")) gestsarr[gestsarrlen-1].distance = DistanceMedium;
						if (!strcmp(gestpt, "S")) gestsarr[gestsarrlen-1].distance = DistanceShort;
						if (!strcmp(gestpt, "*")) gestsarr[gestsarrlen-1].distance = DistanceAny;
						break;
					case 4:
						if (!strcmp(gestpt, "P")) {
							gestsarr[gestsarrlen-1].actmode = ActModePressed;
						} else {
							gestsarr[gestsarrlen-1].actmode = ActModeReleased;
							if (strcmp(gestpt, "R") != 0) {
								//for backward compatibility, allow fourth field to hold command
								gestsarr[gestsarrlen - 1].command = gestpt;
							}
						}
						break;
					case 5: gestsarr[gestsarrlen - 1].command = gestpt; break;
				}
			}
		} else {
			fprintf(stderr, "lisgd [-v] [-d /dev/input/0] [-o 0] [-t 200] [-r 20] [-m 400] [-g '1,LR,L,*,R,notify-send swiped left to right from left edge']\n");
			exit(1);
		}
	}

	// Get display size (if not set with -w/-h)
	if (screenwidth == 0 && screenheight == 0) {
		if (getenv("WAYLAND_DISPLAY")) {
#ifdef WITH_WAYLAND
			wl_display = wl_display_connect(NULL);
			wl_registry = wl_display_get_registry(wl_display);
			wl_registry_add_listener(wl_registry, &wl_registry_listener, NULL);
			wl_display_roundtrip(wl_display);
			wl_display_dispatch(wl_display);
#else
			die("Wayland environment detected but support for it is not enabled");
#endif
		} else if (getenv("DISPLAY")) {
#ifdef WITH_X11
			Display *dpy;
			if (!(dpy = XOpenDisplay(0))) {
				die("Cannot open X display");
			}
			screen = DefaultScreen(dpy);
			if (0 == orientation % 2) {
				screenwidth = DisplayWidth(dpy, screen);
				screenheight = DisplayHeight(dpy, screen);
			} else {
				screenwidth = DisplayHeight(dpy, screen);
				screenheight = DisplayWidth(dpy, screen);
			}
#else
			die("X11 environment detected but support for it is not enabled");
#endif
		} else {
			die("Cannot detect display environment ($DISPLAY and $WAYLAND_DISPLAY unset); and no -w / -h screen geometry parameter options set");
		}
	}

	// E.g. no gestures passed on CLI - used gestures defined in config.def.h
	if (gestsarrlen == 0) {
		gestsarr = malloc(sizeof(gestures));
		if (gestsarr == NULL) {
			perror("Could not allocate memory");
			exit(EXIT_FAILURE);
		}
		gestsarrlen = sizeof(gestures) / sizeof(Gesture);
		memcpy(gestsarr, gestures, sizeof(gestures));
	}

	// Modify gestures swipes based on orientation provided
	for (i = 0; i < gestsarrlen; i++) {
		gestsarr[i].swipe = swipereorient(gestsarr[i].swipe, orientation);
		gestsarr[i].edge = edgereorient(gestsarr[i].edge, orientation);
		//Detect whether ActMode pressed is used
		if (gestsarr[i].actmode == ActModePressed) have_actmode_pressed++;
	}

	run();
	return 0;
}
