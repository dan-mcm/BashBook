
#!/bin/bash

id=$1

if ! [ -d "$id" ];
then
 echo "nok: user $id does not exist" >&2
else
 echo "start_of_file"
 cat "$id"/wall
 echo "end_of_file"
fi
exit 0
