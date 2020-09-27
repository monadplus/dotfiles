#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.xmonad/scripts/set-screen-resolution-in-virtualbox.sh

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

(sleep 2; run $HOME/.config/polybar/launch.sh) &
# Some modules are not properly placed on the bar until all of them load
# This is a dirty trick to reload polybar after boot.
(sleep 40; polybar-msg cmd restart) &

#setxkbmap -layout be #keyboard layout
xsetroot -cursor_name left_ptr & #cursor active at boot


#################################
# Starting utility at boot time #
#################################

# Wallpaper: feh, nitrogen, variety
feh --bg-fill /home/arnau/wallpapers/megumin_purple.png &
#nitrogen --restore &
#run variety &

#run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
#(conky -c $HOME/.xmonad/scripts/system-overview) & #start the conky to learn the shortcuts

run nm-applet & # NetworkManager systray
run pamac-tray & # Package Manager at Tray
run clipmenud & # Clipboard Manager
blueberry-tray & # Bluetooth
picom --config $HOME/.xmonad/scripts/picom.conf & # Window Composer
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & # TODO
/usr/lib/xfce4/notifyd/xfce4-notifyd & # Notifications as pop-ups - xfce4-notifyd-config
udiskie & # Auto-mount disk
# run xfce4-power-manager & # xfce4-power-manager-settings
# run volumeicon & # There is already the polybar icon
# numlockx on &

###########################################
# Starting user applications at boot time #
###########################################

run dropbox &
run enpass &
run thunderbird &
run firefox &
#run thunar & # File Manager
#run spotify &
#run discord &
