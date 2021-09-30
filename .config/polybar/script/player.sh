#!/bin/sh

status=$(mpc | cut "\n")

echo "FIRST LINE $status"[0]
echo "SECOND LINE $status"[1]
echo "LAST LINE $status"[2]

# if [ "$player_artist" != "" ]; then
# 	if [ "$player_status" = "Playing" ]; then
# 	    echo "%{F#FFF} $player_artist - $player_titles"
# 	elif [ "$player_status" = "Paused" ]; then
# 	    echo "%{F#FFF} $player_artist - $player_titles"
# 	elif [ "$player_status" = "Stopped" ]; then
# 	    echo "%{F#FFF} $player_artist - $player_titles"
# 	else
# 	    echo ""
#     fi
# fi
