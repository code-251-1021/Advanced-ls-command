#!/bin/bash
installer()
{
	chmod +x final.sh
	sudo install -m 755 final.sh /usr/local/bin/al
}
if installer;then
	echo "al has been installed sucssfully"
	exit 0
else
	echo "al has beeh installed failed"
	exit 1
fi

