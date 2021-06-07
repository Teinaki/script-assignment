#!bin/bash

input=$1
#if no argument is provided
if [ -z "$1" ]
then
        echo "Enter Directory"
        read input
fi

#if the dictory exists
if [ -d "$input" ]
then
        echo "Creating backup tar in the users home directory"
        tar -czvf ~/backup.tar.gz $input
else
        echo "Error that directory doesn't exist"
        exit 1
fi

echo "Enter IP address or URL of the remote server"
read URL
echo "Enter Port number of the remote server"
read PORT

if [ -z "$1" ]
then
        echo "Target Directory is $input URL is $URL Port number is $PORT"
else
        echo "Target Directory is $1 URL is $URL Port number is $PORT"
fi
