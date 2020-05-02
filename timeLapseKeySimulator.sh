#!/usr/bin/env bash
#
# timelapse keyevent simulator
# by M. Hadi Timachi
#
# inspired by getevent sendevent converter [http://bit.ly/1176SZV] by GermainZ


if [ ! "$(which sendevent)" ]; then
    echo "You need busybox to run this script. You may also need to become root."
    exit 1
fi

printf() {
    busybox printf "$@"
}

sleep() {
    busybox sleep "$@"
}

sed() {
    busybox sed "$@"
}

grep() {
    busybox grep "$@"
}

scroll() {
    sleep 0.1
    echo "$@"
}
separator() {
	scroll
	scroll "*****************************************************"
	scroll
}

runIt() {
    while (( i++ )); : ; do
            sendevent /dev/input/event4    1   "$1"     1
            sendevent /dev/input/event4    0   0             0
            sleep .01
            sendevent /dev/input/event4    1   "$1"     0
            sendevent /dev/input/event4    0   0             0
            sleep "$2"
            echo -en "\r$i"
        done
}

while :; do
    clear
    scroll "Enter delay time between key press"
    read delay
    separator
    scroll "Enter initial delay time"
    read sleepTime
    separator
    scroll "Make a choice"
    scroll "1 => volume up"
    scroll "2 => volume down"
    scroll "0 => restart the input"
    read choice
    separator

    case "$choice" in
        1)
            scroll "Start in $delay seconds with delays of $sleepTime seconds and volume up"
            sleep "$sleepTime"
            runIt 115 $delay
            ;;

        2)
            scroll "Start in $delay seconds with delays of $sleepTime seconds and volume up"
            sleep "$sleepTime"
            runIt 114 $delay
            ;;

        3)
            break
            ;;
    esac
done
