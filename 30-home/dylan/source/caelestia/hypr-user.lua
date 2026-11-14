local vars = require("hypr-vars")

-- Default monitor conf
hl.monitor({
    output   = "eDP-1",
    mode     = "2880x1800@120",
    position = "auto",
    scale    = 1.6,
    vrr      = 3,
})

hl.config({
    gestures = {
        workspace_swipe_distance                 = 700,
        workspace_swipe_cancel_ratio             = 0.15,
        workspace_swipe_min_speed_to_force       = 5,
        workspace_swipe_direction_lock           = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new               = true,
    },
})

-- Gestures
hl.gesture({
    fingers   = vars.gestureFingersMore,
    direction = "down",
    action    = "unset",
})
hl.gesture({
    fingers = vars.gestureFingers,
    direction = "pinch",
    action = "fullscreen",
})