#!/bin/bash

#if statement checks if the pipe server is setup, if not it makes one
if [ ! -p "server.pipe" ]
then
echo Server pipe created.
mkfifo "server.pipe"
fi

read id < "server.pipe" #interpret id from client.sh
echo received from server.pipe id value: $id #test

sleep 1 #prevents bug that put empty character in next read command randomly..

while true; do
read command < "server.pipe" #interpret command from client.sh
echo recevied from server.pipe command value: $command #test

case "$command" in
	create)
	./P.sh
	echo "req params [id]" > "$id.pipe" #replace
	  read id < "server.pipe" #from test.pipe?
	  export id #from test.pipe?
	  ./create.sh > "$id.pipe" #pipe this output back to client...
	 # ./server.sh
	./V.sh
	;;
	add)
	./P.sh
	echo "req params [id friend]" > "$id.pipe"
	  read id friend < "server.pipe"
	  export id friend
	  ./add_friend.sh > "$id.pipe"
	 # ./server.sh
	./V.sh
	;;
	post)
	./P.sh
	echo "req params [sender receiver message]" > "$id.pipe"
	  read sender receiver message < "server.pipe"
	  export sender receiver message
	  ./post_messages.sh > "$id.pipe"
	 # ./server.sh
	./V.sh
	;;
	display)
	echo "req params [id]" > "$id.pipe"
	  read id < "server.pipe"
	  export id
	  ./display_wall.sh > "$id.pipe"
	# ./server.sh
	;;
	*)
	echo "Usage: $0 {create|add|post|display}" > "$id.pipe"
	;;
esac
done

exit 0
