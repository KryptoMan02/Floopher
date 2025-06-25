#!/bin/bash

start_crawler() {
	pythonCMD=$(which python3)
	$pythonCMD ./crawler/crawler.py $1
}
CMS() {
	if [[ $(which curl) = "" ]]; then
		exit
	else
		echo -e "\033[1;34m[*]\033[0m Trying to find the CMS by pattern matching the content in given URL."
		pattern_counter=0
		while SDF= read -r content; do
			resp=$(curl -s $1 | grep $content 2> /dev/null)
			if [[ $resp != "" ]]; then
				echo -e "\033[1;32m[+]\033[0m CMS : \033[1;33m$content\033[0m found"
				pattern_counter=$[$pattern_counter + 1]
			fi
		done < CMS_list.txt
		if [[ $pattern_counter = 0 ]]; then
			echo -e "\033[1;31m[-]\033[0m Couldn't find CMS by pattern matching."
			sleep 1
			echo -e "\033[1;32m[>]\033[0m Proceeding with directory to crawl over pages..."

		fi
	fi
}
banner() {
	echo -e "[1] detect CMS.\n[2] Find XSS or SSTI (Jinja2) in login forms"
	echo -e "[3] Finding XSS or SSTI in GET parameter\n"
	read -p "[.] Option : " option
	return $option
}
if [[ $1 = "" ]]; then
	echo "USAGE : ./floopher.sh <URL>"
else
	echo -e "\n[\033[1;30m?\033[0m] What you wanna do ??.."
	banner
	choice=$?
	if [[ $choice = "1" ]]; then
		echo -e "\033[1;34m[*]\033[0m Finding the CMS being used..."
		CMS $1
	elif [[ $choice = "2" || $choice = "3" ]];then
		echo "[*] Looking for reflecting values..."
	else
		echo "[!] Exception : Invalid Option."
	fi
fi