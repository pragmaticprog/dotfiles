#!/bin/bash 
query="$( echo "" | dmenu -p "Search: " -nb '#141212' -sf '#242423' -sb '#c5a3ff' -nf '#948ca2' <&- )" 
[ -n "${query}" ] && librewolf https://www.qwant.com/?q="${query}"&t=web
