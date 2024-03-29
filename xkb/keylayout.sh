#!/usr/bin/bash

# caps to escape
setxkbmap -option caps:swapescape

# German programmer's dvorak and bulgarian dvorak
# sudo cp ~/config_repo/xkb/de_dvp /usr/share/X11/xkb/symbols
sudo cp ~/config_repo/xkb/bg_dvorak /usr/share/X11/xkb/symbols
setxkbmap -verbose -layout "us(dvorak),bg_dvorak(dvorak), de" -option "grp:shifts_toggle"

sleep 3
printf "\033c"
