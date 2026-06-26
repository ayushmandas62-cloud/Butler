#!/data/data/com.termux/files/usr/bin/bash

pgrep -x picom >/dev/null || picom &
