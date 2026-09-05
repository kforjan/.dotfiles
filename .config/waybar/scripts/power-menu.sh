#!/usr/bin/env bash
set -uo pipefail

WOFI_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/wofi

menu() {
  wofi --dmenu --cache-file /dev/null \
       --conf "$WOFI_DIR/$1" --style "$WOFI_DIR/style.css" --prompt "$2"
}

choice=$(printf '%s\n' \
  "  Lock" \
  "  Suspend" \
  "  Reboot" \
  "  Shut down" \
  "󰗽  Log out" | menu power.conf "Power")

[[ -z ${choice:-} ]] && exit 0

case $choice in
  *Lock*)        action=(hyprlock);                  confirm=no  ;;
  *Suspend*)     action=(systemctl suspend);         confirm=yes ;;
  *Reboot*)      action=(hyprshutdown -t "Rebooting..."    -p "systemctl reboot");   confirm=yes ;;
  *"Shut down"*) action=(hyprshutdown -t "Shutting down..." -p "systemctl poweroff"); confirm=yes ;;
  *"Log out"*)   action=(hyprctl dispatch exit);     confirm=yes ;;
  *) exit 0 ;;
esac

if [[ $confirm == yes ]]; then
  label=$(printf '%s' "$choice" | sed 's/^[^A-Za-z]*//')
  answer=$(printf '%s\n' "  No" "  Yes, $label" | menu confirm.conf "$label?")
  [[ $answer == *"Yes"* ]] || exit 0
fi

exec "${action[@]}"
