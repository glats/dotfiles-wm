#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

# Wait until polybar have been completely shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 2; done

echo 'Launching polybar...'
polybar main &

# Start applets if they're not running
for arg in "xfce4-clipman" "nm-applet" "caffeine"
do
    if ! ps ax | grep -v grep | grep -io "$arg"
    then
        echo "Launching $arg"
        exec $arg &
    fi
done

echo 'Polybar launched'
exit 0
