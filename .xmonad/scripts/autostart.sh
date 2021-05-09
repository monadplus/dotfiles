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

#setxkbmap -layout be #keyboard layout
xsetroot -cursor_name left_ptr & #cursor active at boot


#################################
# Starting utility at boot time #
#################################

# run variety & # wallpaper
run nm-applet & # networkManager systray
run pamac-tray & # package manager at tray
run clipmenud & # clipboard manager
run blueberry-tray & # bluetooth
hostname=$(cat /proc/sys/kernel/hostname)
if [ $hostname = "laptop" ]; then
  echo 'nothing to execute yet'
else
  # FIXME
  #source $HOME/.xmonad/scripts/password
  #(sleep 5; echo $MYPASS | sudo -S bash -c 'fancontrol &') &
  (sleep 5; liquidctl initialize; liquidctl set sync speed 30; liquidctl set sync color off) &
  # run polychromatic-tray-applet &
  # run streamlink-twitch-gui &
  # run lutris &
fi
feh --bg-scale ~/dotfiles/wallpapers/manga_black_wallpaper.jpg
#picom --config $HOME/.xmonad/scripts/picom.conf & # window composer
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd & # Notifications as pop-ups - xfce4-notifyd-config
udiskie & # automount disk
# redshift & # Screen color warm

###########################################
# Starting user applications at boot time #
###########################################

run dropbox &
run enpass &
run thunderbird &
run firefox &

xset r rate 265 40
