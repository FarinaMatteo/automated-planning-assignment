#!/bin/bash

# ask the user for his/hers plansys2 installation folder
confirmation="n"
DEFAULT_FOLDER=~/plansys2_ws
while [[ $confirmation != "y" && $confirmation != "Y" ]];
do
    confirmation="y"
    printf "Type your plansys2 installation folder. Omit the trailing slash at the end. (Default: %s)\n" $DEFAULT_FOLDER
    read -p "plansys2 installation folder [ENTER for default]: " INSTALLATION_FOLDER
    if [[ $INSTALLATION_FOLDER = "" ]]; then
        INSTALLATION_FOLDER=$DEFAULT_FOLDER
    else
        printf "Your installation folder is $INSTALLATION_FOLDER\n"
        read -p "Confirm? [Y/n] " confirmation
        echo "Confirmation " $confirmation
        if [[ $confirmation = "" ]]; then
            confirmation="y"
        fi
        while [[ $confirmation != "y" && $confirmation != "Y" && $confirmation != "n" && $confirmation != "N" ]]
        do
            echo "here"
            read -p "Confirm? [Y/n]" confirmation
        done
    fi
    clear
done
clear
printf "Your installation folder is $INSTALLATION_FOLDER.\n"
printf "The installation will build the current directory and override the %s/install/plansys2_assignment\
 and %s/build/plansys2_assignment folders if they exist.\n" $INSTALLATION_FOLDER $INSTALLATION_FOLDER

confirmation="none"
while [[ $confirmation != "y" && $confirmation != "Y" && $confirmation != "n" && $confirmation != "N" ]];
do
    read -p "Continue? [Y/n] " confirmation
    if [[ $confirmation = "" ]]; then
        confirmation="y"
    fi
    if [[ $confirmation != "y" && $confirmation != "Y" && $confirmation != "n" && $confirmation != "N" ]]; then
        echo "Please provide a valid confirmation input."
    fi
done

if [[ $confirmation = "y" || $confirmation = "Y" ]]; then
    # locate files in the plansys2 folder so that they can be referenced by PATH
    colcon build --symlink-install --allow-overriding plansys2_assignment
    rosdep install --from-paths . --ignore-src -r -y
    colcon build --symlink-install --allow-overriding plansys2_assignment

    if [ -d $INSTALLATION_FOLDER/install/plansys2_assignment ]; then
        rm -rf $INSTALLATION_FOLDER/install/plansys2_assignment
        echo "Removing previously existing 'install' folder."
    fi
    cp -RT install/plansys2_assignment $INSTALLATION_FOLDER/install/plansys2_assignment

    if [ -d $INSTALLATION_FOLDER/build/plansys2_assignment ]; then
        rm -rf $INSTALLATION_FOLDER/build/plansys2_assignment
        echo "Removing previously existing 'build' folder."
    fi
    cp -RT build/plansys2_assignment ~/plansys2_ws/build/plansys2_assignment
else
    echo "Command abort."
fi