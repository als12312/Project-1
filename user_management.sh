#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c, --create <username>  Create a new user"
    echo "  -d, --delete <username>  Delete an existing user"
    echo "  -p, --password <username>  Change password for a user"
    echo "  -h, --help               Display this help message"
}

# Function to create a new user
create_user() {
    username=$1
    sudo adduser $username
    echo "User $username created successfully."
}

# Function to delete an existing user
delete_user() {
    username=$1
    sudo deluser $username
    echo "User $username deleted successfully."
}

# Function to change password for a user
change_password() {
    username=$1
    sudo passwd $username
}

# Main script starts here
if [ $# -eq 0 ]; then
    usage
    exit 1
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -c|--create)
            create_user $2
            shift 2
            ;;
        -d|--delete)
            delete_user $2
            shift 2
            ;;
        -p|--password)
            change_password $2
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
