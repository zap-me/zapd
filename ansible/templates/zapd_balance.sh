#!/bin/bash


bal=`curl -s -d '{"jsonrpc":"2.0","id":1,"method":"getbalance","params":{}}' -H "Content-Type: application/json-rpc" localhost:5000/api | jq '.["result"]["balance"]'`
min_bal=500000
max_bal=1000000
dest_email=alerts@zap.me


if [ $bal -lt $min_bal ]; then
        echo "balance $bal is less than 5000 ZAP" | mail -s "The balance is less than 5000 ZAP" $dest_email
elif [ $bal -gt $max_bal ]; then
        echo "balance $bal is greater than 10000 ZAP" | mail -s "The balance is greater than 100000 ZAP" $dest_email
else
        exit
fi

exit
