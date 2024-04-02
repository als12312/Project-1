#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c, --create <username>   Create a new user"
    echo "  -a, --add <username>      Add an existing user"
    echo "  -d, --delete <username>   Delete an existing user"
    echo "  -m, --modify <username>   Modify an existing user"
    echo "  -h, --help                Display this help message"
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
        -a|--add)
            add_user $2
            shift 2
            ;;
        -d|--delete)
            delete_user $2
            shift 2
            ;;
        -m|--modify)
            modify_user $2
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
