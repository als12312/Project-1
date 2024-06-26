#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c, --create-user <username>      Create a new user"
    echo "  -a, --add-user <username>         Add an existing user"
    echo "  -d, --delete-user <username>      Delete an existing user"
    echo "  -m, --modify-user <username>      Modify an existing user"
    echo "  -g, --create-group <groupname>    Create a new group"
    echo "  -ga, --add-group <username> <groupname>  Add a user to a group"
    echo "  -gd, --delete-group <groupname>   Delete an existing group"
    echo "  -b, --backup <directory>          Backup specified directory"
    echo "  -h, --help                         Display this help message"
}

# Function to create a new user
create_user() {
    username=$1
    sudo useradd -m $username
    echo "User $username created successfully."
}

# Function to add an existing user
add_user() {
    username=$1
    sudo usermod -aG sudo $username  # Example: adding user to sudo group
    echo "User $username added successfully."
}

# Function to delete an existing user
delete_user() {
    username=$1
    sudo deluser $username
    echo "User $username deleted successfully."
}

# Function to modify an existing user
modify_user() {
    username=$1
    sudo usermod -aG sudo $username  # Example: adding user to sudo group
    echo "User $username modified successfully."
}

# Function to create a new group
create_group() {
    groupname=$1
    sudo groupadd $groupname
    echo "Group $groupname created successfully."
}

# Function to add a user to a group
add_to_group() {
    username=$1
    groupname=$2
    sudo usermod -aG $groupname $username
    echo "User $username added to group $groupname successfully."
}

# Function to delete an existing group
delete_group() {
    groupname=$1
    sudo groupdel $groupname
    echo "Group $groupname deleted successfully."
}

# Function to backup a directory
backup_directory() {
    directory=$1
    timestamp=$(date +"%Y%m%d_%H%M%S")
    backup_filename="backup_${timestamp}.tar.gz"
    tar -czvf $backup_filename $directory
    echo "Backup of $directory created successfully: $backup_filename"
}

# Main script starts here
if [ $# -eq 0 ]; then
    usage
    exit 1
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -c|--create-user)
            create_user $2
            shift 2
            ;;
        -a|--add-user)
            add_user $2
            shift 2
            ;;
        -d|--delete-user)
            delete_user $2
            shift 2
            ;;
        -m|--modify-user)
            modify_user $2
            shift 2
            ;;
        -g|--create-group)
            create_group $2
            shift 2
            ;;
        -ga|--add-group)
            add_to_group $2 $3
            shift 3
            ;;
        -gd|--delete-group)
            delete_group $2
            shift 2
            ;;
        -b|--backup)
            backup_directory $2
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done
