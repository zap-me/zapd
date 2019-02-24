#!/bin/bash

dest_email={{ ALERT_EMAIL }}
max_height_diff=2

remote_block=`curl -s https://{{ REMOTE_WAVES_NODES }}/blocks/height | jq '.["height"]'` 
local_block=`curl -s localhost:6869/blocks/height | jq '.["height"]'`

### Condition to compare two values.
if [ $remote_block > $local_block ]; then
	num=$(( $remote_block - $local_block ))
	if [ $num -ge $max_height_diff ]; then
		echo "The remote node is at $remote_block while the local node is at $local_block." | mail -s "The nodes are not synced" $dest_email
	else
		exit
	fi
elif [ $local_block > $remote_block ]; then
	num=$(( $local_block - $remote_block ))
	if [ $num -ge $max_height_diff ]; then
		echo "The local node is at $local_block while the remote node is at $remote_block." | mail -s "The nodes are not synced" $dest_email
	else
		exit
	fi
else
	exit
fi

