#!/bin/bash

dest_email={{ ALERT_EMAIL }}
max_height_diff=2


{% if DEPLOY_HOST == 'testnet.zap.me' %}
  {% set node_address =  'testnet1.wavesnodes.com' %}
{% else %}
  {% set node_address = 'nodes.wavesnodes.com' %}
{% endif %}

remote_block=`curl -s https://{{ node_address }}/blocks/height | jq '.["height"]'` 
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

