#!/bin/bash

PICTURE=/tmp/i3lock.png

maim $PICTURE
convert $PICTURE -blur 5x4 $PICTURE
i3lock --image $PICTURE --pointer default
rm $PICTURE
