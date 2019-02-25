#!/bin/bash

dest_email={{ ALERT_EMAIL }}
max_height_diff=2

remote_block=`curl -s https://{{ REMOTE_WAVES_NODES }}/blocks/height | jq '.["height"]'` 
local_block=`curl -s localhost:6869/blocks/height | jq '.["height"]'`

### Condition to compare two values.
num=$(( $remote_block - $local_block ))
if [ $num -lt 0 ]; then
	num=$((-$num))
fi
if [ $num -ge $max_height_diff ]; then
	echo "The remote node is at $remote_block while the local node is at $local_block." | mail -s "The nodes are not synced" $dest_email
else
	exit
fi
