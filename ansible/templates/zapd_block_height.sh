#!/bin/bash

dest_email=alerts@zap.me
remote_block=`curl -s https://testnode1.wavesnodes.com/blocks/height | jq '.["height"]'` 
local_block=`curl -s localhost:6869/blocks/height | jq '.["height"]'`
max_height_diff=2

### Remote block would be same/higher than local block.
num=$(( $remote_block - $local_block ))

if [ $num -ge $max_height_diff ]; then
	echo "The remote node is at $remote_block while the local node is at $local_block" | mail -s "WAVE Local Node is not synced" $dest_email
else
	exit
fi

