#!bin/bash

if [ -z "$1" ]
then
        echo "Enter Directory"
        read DIRECTORY
fi

echo "Enter IP address or URL of the remote server"
read URL
echo "Enter Port number of the remote server"
read PORT

if [ -z "$1" ]
then
        echo "Target Directory is $DIRECTORY URL is $URL Port number is $PORT"
else
        echo "Target Directory is $1 URL is $URL Port number is $PORT"
fi
