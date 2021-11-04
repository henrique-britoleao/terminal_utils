#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# default installation path 
LAB_PATH=~
# ask user if use default path or not
echo "The default installation path is: ${LAB_PATH}"
while true; do
    read -p  "Do you wish to change it? [Yes/No]: " yn
    case $yn in    
        [Yy]* ) read -p "Enter installation path: " LAB_PATH; break;;
        [Nn]* ) break;;
        * ) "Please enter a valid command";;
    esac
done
# copy files to installation path
mkdir -p ${LAB_PATH}/lab_terminal_utils
cp ${SCRIPT_DIR}/.labrc ${LAB_PATH}/lab_terminal_utils  
cp ${SCRIPT_DIR}/ignore.template ${LAB_PATH}/lab_terminal_utils
cp ${SCRIPT_DIR}/lab.sh ${LAB_PATH}/lab_terminal_utils

# default rc file
RC_FILE_PATH=~/.zshrc
# ask user if use default rc file or not
echo "The default rc file is: ${RC_FILE_PATH}"
while true; do
    read -p  "Do you wish to change it? [Yes/No]: " yn
    case $yn in    
        [Yy]* ) read -p "Enter rc file path: " RC_FILE_PATH; break;;
        [Nn]* ) break;;
        * ) "Please enter a valid command";;
    esac
done
# add alias to terminal rc file
echo "alias lab='bash ${LAB_PATH}/lab_terminal_utils/lab.sh'" >> ${RC_FILE_PATH}