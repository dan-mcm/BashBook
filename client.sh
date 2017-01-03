#!/bin/bash
id=$1

if [ ! -p "$id.pipe" ]
then
echo "$id.pipe created"
echo "Welcome $id!"
echo "Use Commands: create | add | post | display"
mkfifo "$id.pipe"
fi

# trap  ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c(){
rm "$id.pipe"
echo " $id now disconnected - pipe erased" #test
exit 0
}

if [ $# -ge 1 ] #checks if parameters have been given and sets while loop con.
then
 	x="true";
	echo $id > "server.pipe"
else
	x="false";
fi

while [ $x = "true" ]; do

read command arg1 arg2 arg3
#echo commands received were: $command $arg1 $arg2 $arg3 #test statement
echo "$command $arg1 $arg2 $arg3" > "server.pipe" #sends args through pipe

read serverResponse < "$id.pipe" #need to setup custom user pipes...

echo message received from server: $serverResponse

#cat < "$id.pipe" # this spits out the full length of the cat in wall
# cat above also breaks error repeat message....

done
