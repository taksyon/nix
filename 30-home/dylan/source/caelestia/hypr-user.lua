local vars = require("hypr-vars")

-- Default monitor conf
hl.monitor({
    output   = "eDP-1",
    mode     = "2880x1800@120",
    position = "auto",
    scale    = 1.5,
    vrr      = 0,
    cm       = "srgb",
})

-- Persistent workspaces (1-10)
for i = 1, 10 do
    hl.workspace_rule({
        workspace = i,
        persistent = true,
    })
end

-- Config options
hl.config({
    gestures = {
        workspace_swipe_distance                 = 700,
        workspace_swipe_cancel_ratio             = 0.15,
        workspace_swipe_min_speed_to_force       = 5,
        workspace_swipe_direction_lock           = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new               = true,
    },

    misc = {
        middle_click_paste = false,
    },

    render = {
        direct_scanout = 0,
        -- Don't auto-switch the monitor to HDR when a fullscreen app requests it
        -- (causes a full modeset / display blank, e.g. fullscreening VSCode)
        cm_auto_hdr    = 0,
    },
})

-- Gestures
hl.gesture({
    fingers   = vars.gestureFingersMore,
    direction = "down",
    action    = "unset",
})
hl.gesture({
    fingers   = vars.gestureFingers,
    direction = "pinch",
    action    = "fullscreen",
})
