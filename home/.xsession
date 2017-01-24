xsetroot -solid rgb:24/24/34

setxkbmap -option compose:ralt

xrdb .Xresources

if [ -f /usr/local/bin/xbattbar ]; then
	xbattbar 2>/dev/null &
fi

cwm
