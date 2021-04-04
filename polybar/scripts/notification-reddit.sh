#!/bin/sh

URL="https://www.reddit.com/message/unread/.json?feed=55d4f2a5a696da6a20388499f20c94e143a14ff0&user=Abellix"
USERAGENT="~/.config/polybar/scripts/notification-reddit:v1.0 u/reddituser/Abellix"

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
    echo "#1 $notifications"
else
    echo "#2"
fi
