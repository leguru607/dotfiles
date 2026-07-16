#!/bin/bash
case "$1" in
    up)   pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    down) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
    mute) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac
vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -1)
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no')
if [ "$muted" = "yes" ]; then
    dunstify -a volume -r 9991 -u low -i audio-volume-muted -h string:x-canonical-private-synchronous:volume -h int:value:0 "Muted"
else
    dunstify -a volume -r 9991 -u low -i audio-volume-high -h string:x-canonical-private-synchronous:volume -h int:value:"$vol" "Volume: $vol%"
fi
