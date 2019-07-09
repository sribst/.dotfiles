#!/bin/sh

killall polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar topbar    -c ~/.config/polybar/topbar    &
      MONITOR=$m polybar bottombar -c ~/.config/polybar/bottombar &
  done
else
    polybar topbar    -c ~/.config/polybar/topbar    &
    polybar bottombar -c ~/.config/polybar/bottombar
fi
