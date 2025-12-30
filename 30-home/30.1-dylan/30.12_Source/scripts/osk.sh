#!/usr/bin/env sh
set -eu

ACTION="${1:-toggle}" # on/off
SWITCH_KB="at-translated-set-2-keyboard"

# Hyprland device enable/disable
set_kb() {
    val="$1" # true/false
    hyprctl keyword "device[$SWITCH_KB]:enabled" "$val" 2>/dev/null || \
    hyprctl keyword "device:$SWITCH_KB:enabled" "$val" 2>/dev/null || true
}

osk_on() {
    # squeekboard honors this
    gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true
    systemctl --user start squeekboard.service 2>/dev/null || true
    # keep hidden until a text field is focused
    busctl --user call sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b false 2>/dev/null || true
}

osk_off() {
    busctl --user call sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b false 2>/dev/null || true
    gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
    systemctl --user stop squeekboard.service 2>/dev/null || true
}

case "$ACTION" in
    on)
        osk_on
        set_kb false
    ;;
    off)
        osk_off
        set_kb true
    ;;
esac
