#!/usr/bin/env bash

emit() {
  if ip link show proton0 &>/dev/null; then
    printf '{"text":"󰒃","class":"connected","tooltip":"VPN up (proton0)"}\n'
  else
    printf '{"text":"󰦞","class":"disconnected","tooltip":"VPN down"}\n'
  fi
}

emit
# `ip monitor` exits if the netlink socket dies; waybar restarts us.
ip monitor link | while read -r _; do
  emit
done
