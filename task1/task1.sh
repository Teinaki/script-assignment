#!bin/bash

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
        echo "Enter full path to csv"
        read input
fi

if [ -z "$input" ]
then
        echo "No input data in csv format"
        exit 1
fi

file=$input
IFS=";"

while read col1 col2 col3 col4
do
echo "Column 1 value: $col1"

#split the name into an array from the email by where the period is.
IFS='.'
read -a namearr <<< "$col1"



echo "Column 2 value: $col2"
echo "Column 3 value: $col3"
echo "Column 4 value: $col4"


#takes the first part of the name in the created array and gets the 1st char and adds it with the next value
firstname="${namearr[0]}"
user="${firstname:0:1}${namearr[1]}"
user=${user%@*}
#then it drops everything from the @ sign and further

#makes a password by taking the column and putting it in month year date format
#then it will drop all '-' occurances
pass=$(date -d "$col2" +"%m-%Y" | tr -d -)

#will now add the user with a user directory made earlier from the email
sudo useradd -d /home/$user -m -s /bin/bash $user
sudo echo "$user:$pass" | sudo chpasswd

#set the users last change of password to 0 so it will be expired and they will have to update on next login
sudo chage --lastday 0 $user

#here we create directories from the shared directory the user needs access to
#if the directory already exists then a message will be sent or the directory is then created.
if [ -d "/home$col4" ]; then
        echo "/home$col4 Already Exists"
else
        #the directory is created with the permissions set to 770, so the owner and group can read,write,execute
        #but others can't do anything to the directory
        echo "Error: $/home$col4 not found. Making Directory."
        sudo mkdir -m 770 "/home$col4"
fi


#this will split the groups a user can belong to into an array by changing IFS to ','
IFS=','
read -a grouparr <<< "$col3"

#get the length of the array so we can iterate through it
grouplen=${#grouparr[@]}

#Goes through the grouparr to see if group the user needs to be part of is created.
for (( i=0; i < $grouplen; i++ ))
do
        #if the group is created then nothing needs to happen
        if grep -q ${grouparr[i]} /etc/group
        then
                echo "group ${grouparr[i]} exists."
        else
                #the group needs made before the user can be assigned to it.
                echo "Creating group ${grouparr[i]}"
                sudo groupadd ${grouparr[i]}

                #on creation of the group it will check if the first 4 characters is the same as the shared
                #folder that the user was assigned, if they are then the group gets ownership
                if [ ${col4:1:4} == ${grouparr[i]:0:4} ]; then
                        sudo chown -R :${grouparr[i]} "/home$col4"
                fi

        fi

        #if the user is in group sudo then they are given the alias command off in their .bash_aliases file
        if [ ${grouparr[i]} == "sudo" ]; then
                sudo echo "alias off='systemctl poweroff'" >> /home/$user/.bash_aliases
        fi

        #then the user is assigned to the group
        sudo usermod -a -G ${grouparr[i]} $user
done

#the softlinks are then created for the user in their home directory that is linked to the shared folders
if [ "$col4" != '' ]; then
        sudo ln -s "/home$col4" /home/$user/groupFiles
fi
#had problems with the links being created for the hole directory so I made sure the string wasn't empty for $col4

#IFS is then set back to ';' for the next row in the file
IFS=';'
done < $file