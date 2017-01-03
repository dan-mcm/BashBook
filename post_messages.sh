#!/bin/bash
sender=$1
receiver=$2
message=$3


if ! [ -d "$sender" ]; #if sender doesn't exist...
then
echo "nok: user $sender does not exist" #posts to client
exit 3
fi

if ! [ -d "$receiver" ]; #if receiver doesn't exist...
then
echo "nok: user $receiver does not exist" #posts to client
exit 2
fi

if grep "$sender" "$receiver"/friends; then
./P.sh "$sender.lock"
echo "$sender: $message" >> "$receiver"/wall
echo "ok"
./V.sh "$sender.lock"
else
echo "$sender is not a friend of $receiver"
exit 1
fi

exit 0
