#!/bin/bash
id=$1
friend=$2

if ! [ -d "$id" ];
then
echo "username $id does not exist!"
exit 2
fi

if ! [ -d "$friend" ];
then
echo "nok: user $friend does not exist!"
exit 2
fi


if grep "^$friend" "$id"/friends > /dev/null
then
echo "User already in Friends list!"
exit 1
fi

./P.sh "$id.lock"
echo "$friend" >> "$id"/friends #minor bug - prints out to terminal...
echo "ok" #auto directs to client
./V.sh "$id.lock"
exit 0
