#!/bin/bash

id=$1

if [ -z "$id" ]; #if the value of id has no words..
then
echo "nok: no identifier provided" #prints out on client side
exit 2
fi

if [ -d "$id" ];
then
echo "nok: user already exists"  #prints out on client side
exit 1
fi

./P.sh "$id.lock"
echo "user created!" #prints out on client side
mkdir "$id" #accounts for space in name
touch "$id"/wall
touch "$id"/friends
./V.sh "$id.lock"
exit 0
