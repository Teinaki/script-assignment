#!bin/bash

#error checking function
error_exit() {
	echo ">Error code $1"
	echo ">$2"
	echo "Exiting"
	exit 1
}

input=$1
#if no argument is provided
if [ -z "$1" ]
then
        echo "Enter full path to directory that is being backed up"
        read input
fi

#if directory exists
if [ -d "$input" ]
then
        #get the name of the final directory, ommiting everything before '/'
        enddir=${input##*/}
        echo "Creating Tar of directory in the users home directory"
        #makes tar with the name of the directory being backed up
        tar -czvf ~/$enddir.tar.gz $input
else
        echo "Error that directory doesn't exist"
        exit 1
fi

#user input for the securely copy file
echo "Enter IP address or URL of the remote server" #only allowed ip address for now
read URL
echo "Enter Port number of the remote server"
read PORT
echo "Enter target user on the remote server"
read USER
echo "Enter full path for target directory to save to"
read DIR

#should have tests to see if these values are valid before using scp command

#will take the user data just added and attempt to copy the tar.gz to there
scp -P $PORT ~/$enddir.tar.gz $USER@$URL:$DIR
#most likely will ask for login details on the remote host