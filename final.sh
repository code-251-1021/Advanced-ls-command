#!/bin/bash
os_release()
{
	source /etc/os-release
	local family="${ID_LIKE,,} ${ID,,}"
	case "$family" in
		*debian*)
			sudo apt install -y "$n"
			;;
		*arch*)
			sudo pacman -S --noconfirm --needed "$n"
			;;
		*fedora*|*rhel*)
			sudo dnf install -y "$n"
			;;
		*)
			echo "Error:Script just work correctly with debian,arch,fedora"
			;;
	esac
}

download_install_tools() 
{
	tools=("espeak")
	for n in "${tools[@]}"
	do
		if command -v "$n" >/dev/null 2>&1; then
			continue
		else
			# checking for tools
			read -p "Do you want to download and install essential tool ($n)? [y/n] " tools_ans
			local tools_ans="${tools_ans,,}"
			if [[ "$tools_ans" != "y" && "$tools_ans" != "yes" ]]; then
				echo "Script has been canceled"
				return 1
			fi
			echo "Installing $n..."
			os_release
		fi
	done
	return 0
}

download_install_tools || exit 1

# checking for input arguments
if [ $# -eq 0 ]; then
	espeak "Error: No argument was detected!"
	echo "Usage: $0 [OPTION] [PATH]"
	exit 1
fi

yellow='\033[33m'
green='\033[32m'
nc='\033[0m'

# helper function for checking permissions
get_permission() {
	local target="$1"

	if [ -r "$target" ]; then
		read_perm="-r"
	else
		read_perm="-*"
	fi

	if [ -w "$target" ]; then
		write_perm="-w"
	else
		write_perm="-*"
	fi

	if [ -x "$target" ]; then
		execute_perm="-x"
	else
		execute_perm="-*"
	fi
}

# flags functions
help_flag() {
	echo "
Usage: final.sh [OPTION] [PATH]

An advanced 'ls' utility to list directory contents with flexible filtering.

Options:
  -f         Shows files only (names only, no metadata)
  -d         Shows directories only (names only, no metadata)
  -a         Shows all files and directories with full details
  -p         Shows files permision
  -h         Display this help and exit
Examples:
  ./final.sh -f /var/log
  ./final.sh -a

install:
	installer.sh is a file that can install final.sh on your machine as command
Author: Amir Rezaei
"
}

file_flag() {
	for n in *
	do
		[ -e "$n" ] || continue
		if [ -f "$n" ]; then
			echo -e "${yellow}$n${nc}"
		fi
	done
}

folder_flag() {
	for n in *
	do
		[ -e "$n" ] || continue
		if [ -d "$n" ]; then
			echo -e "${yellow}$n${nc}"
		fi
	done
}

all_info_flag() {
	for n in *
	do
		[ -e "$n" ] || continue

		get_permission "$n"

		if [ -f "$n" ]; then
			size=$(wc -c < "$n")
			lines=$(wc -l < "$n")
			echo -e "| permission: $read_perm $write_perm $execute_perm | size: $size bytes lines : $lines, ${yellow}$n${nc}"
		else
			echo -e "| permission: $read_perm $write_perm $execute_perm | ${green}$n${nc}"
		fi
	done
}

permision_only()
{
	for n in *
	do
		[ -e "$n" ] || continue

		get_permission "$n"

		if [ -f "$n" ]; then
			echo -e "| permision : $read_perm $write_perm $execute_perm | ${yellow}$n${nc}"
		elif [ -d "$n" ]; then
			echo -e "| permision : $read_perm $write_perm $execute_perm | ${green}$n${nc}"
		fi
	done
	return 0
}

first_argument="$1"
shift

file_all_flag()
{
	for n in *
	do
		[ -e "$n" ] || continue

		get_permission "$n"

		if [ -f "$n" ]; then
			size=$(wc -c < "$n")
			lines=$(wc -l < "$n")
			echo -e "| permission: $read_perm $write_perm $execute_perm | size: $size bytes lines : $lines, ${yellow}$n${nc}"
		fi
	done
}

dir_all_flag()
{
	for n in *
	do
		[ -e "$n" ] || continue

		get_permission "$n"

		if [ -f "$n" ];then
			continue
		fi
		if [ -d "$n" ];then
			echo -e "| permission: $read_perm $write_perm $execute_perm | ${green}$n${nc}"
		fi
	done
}

does()
{
	case "$first_argument" in
		"-f")
			file_flag
			;;
		"-d")
			folder_flag
			;;
		"-a") 
			all_info_flag
			;;
		"-h") 
			help_flag
			;;
		"-p")
			permision_only
			;;
		"-fa"|"-af")
			file_all_flag
			;;
		"-da"|"-ad")
			dir_all_flag
			;;
		*)    
			espeak "Eror: Invalid flag type -h for help"
			;;
	esac
}

if [ -z "$1" ]; then
	does
elif [ ! -d "$1" ]; then
	espeak "Error: Directory  does not exist!"
	exit 1
else
	cd "$1"
	does
fi
