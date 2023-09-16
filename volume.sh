#!/bin/sh
# volume.sh - get/set the volume on MacOSX using osascript
# Copyright (c) 2023 Sriranga Veeraraghavan <ranga@calalum.org>.
# All rights reserved.  See LICENSE.txt.
#
# v.0.1.0 - initial version
#

# required external programs

OSASCRIPT="/usr/bin/osascript"
SED="/usr/bin/sed"

# min and max volume

VOL_MUTE=0
VOL_MAX=7

# convenience arguments

ARG_MUTE="mute"
ARG_MAX="max"

# getVolume - use osascript to get the current volume

getVolume()
{
   "$OSASCRIPT" -e 'get volume settings' 2> /dev/null | \
   "$SED" -e 's/\,.*$/\%/' -e's/^.*\://';
   return $?;
}

# check to see if required commands are available

for CMD in "$OSASCRIPT" "$SED" ;
do
    if [ ! -x "$CMD" ] ; then
        echo "ERROR: $CMD not found!" 1>&2 ;
        exit 1;
    fi
done

# if invoked as "mute", set the volume to 0 and exit

PGM="`echo $0 | $SED -e 's#^.*\/##'`"
if [ X"$PGM" = X"mute" ] ; then
   "$OSASCRIPT" -e "set volume $VOL_MUTE" > /dev/null 2>&1;
   EC=$?;
   if [ X"$EC" = X"0" ] ; then
       getVolume;
   fi
   exit $EC;
fi

# if no arguments are given, print out the current volume

if [ X"$1" = "X" ] ; then
   getVolume;
   exit $?;
fi

# if the argument is "mute" or "max", set the volume to 0
# or the maximum, respectively; otherwise pass the argument
# to osascript

EC=1
case "$1" in
    "$ARG_MUTE")
        "$OSASCRIPT" -e "set volume $VOL_MUTE" > /dev/null 2>&1;
        EC=$?;
        if [ X"$EC" = X"0" ] ; then
            getVolume;
        fi
        ;;
    "$ARG_MAX")
        "$OSASCRIPT" -e "set volume $VOL_MAX" > /dev/null 2>&1;
        EC=$?;
        if [ X"$EC" = X"0" ] ; then
            getVolume;
        fi
        ;;
    *)
        "$OSASCRIPT" -e "set volume $1" > /dev/null 2>&1;
        EC=$?;
        if [ X"$EC" = X"0" ] ; then
            getVolume;
        fi
        ;;
esac

exit $EC

