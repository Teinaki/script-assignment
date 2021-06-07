# script-assignment


Author details:
– Your full name: Teinaki McFelin
– You student code: mcfetk1
– last Changes were made around 12:00 am 8/06/2021


• Project details for each of the two scripts:
– Summary of the purpose of the script
    Purpose of the Task 1 script is to automate the process of user creation, followed by configuration of the user environment on a Ubuntu Linux system. The script will ingest a file containing user-related information, and should create users based on the information in the provided file. Additionally, the script should perform a basic configuration of the user environment including creation of secondary groups, shared folders and setting of
    permissions. 

    Purpose of the Task 2 script is it compresses a given folder and uploads it to a remote location – this is essentially a backup script.

– Pre-requisites of running the script
    Log into the vRealize VM

    then ssh into a user
        example ssh student@[IP ADDRESS]
    The Scripts should be run with sudo.
    The scripts are in the /home/student/assignment directory but another copy could be used if more suited

    Pass a csv file into the task1 script with layout of "e-mail;birth date;groups;sharedFolder"
        make sure there are 4 columns, the email and birth date are required for script functionality


– Instructions on how to run the script, including example commands

    #If using is in the same directory as both the files
    sudo bash task1.sh taskData.csv

    #or the user can leave out the csv and give it as a read input
    sudo bash task1.sh
    taskdata.csv

    #The user can also run it if given the absolute directory path
    sudo bash /home/student/task1.sh /home/student/taskData.csv

    #similar options with the task2 script, it only needs 1 file
    #but also requires a directory to copy/backup
    sudo bash task2.sh /home/student

    #or you can still run the script then pass in the directory as read input
    sudo bash task2.sh
    /home/student

    #same as the other script with use of using absolute path if not in the same directory