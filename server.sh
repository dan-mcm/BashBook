#!/bin/bash

#if statement checks if the pipe server is setup, if not it makes one
if [ ! -p "server.pipe" ]
then
echo Server pipe created.
mkfifo "server.pipe"
fi

read id < "server.pipe" #interpret id from client.sh
# echo received from server.pipe id value: $id - test statement

sleep 1 #prevents bug that put empty character in next read command randomly.. may be local keyboard issue..

while true; do
read command arg1 arg2 arg3 < "server.pipe"
#echo command: $command arg1: $arg1 arg2: $arg2 arg3: $arg3 - test statement

case "$command" in
	create)
	  #echo within create loop - test statement
	  ./create.sh $arg1 > "$id.pipe"
	;;
	add)
	  #echo within add friend loop - test statement
	  ./add_friend.sh $arg1 $arg2 > "$id.pipe"
	;;
	post)
	  #echo within post message loop - test statement
	  ./post_messages.sh $arg1 $arg2 $arg3 > "$id.pipe"
	;;
	display)
	  #echo within display loop - test statement
	  ./display_wall.sh $arg1 > "$id.pipe" #only displays 1 line...
	;;
	*)
	#echo within other loop - test statement
	echo "Usage: $0 {create|add|post|display}" > "$id.pipe"
	#BUG: only allows one error input? - cannot handle second error?
	#BUG suspected cause - read element within while loop?
esac
done

exit 0
