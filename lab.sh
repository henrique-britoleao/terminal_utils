#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/.labrc

function create_project () {
    local projects_dir=${ROOT_DIR}/$1 # TODO: Add config to change root dir
    mkdir -v -p $projects_dir/bin # create folder
    cat ${SCRIPT_DIR}/ignore.template > ${projects_dir}/.gitignore # add gitignore
    cd $projects_dir && touch README.md # add empty readme
    git init 
    code $projects_dir # open code
}

function usage (){
    printf "usage: lab command ...\n\n"
    printf "lab is a tool for creating and managing pytho projects.\n\n"
    printf "Options:\n\n"
    printf "positional arguments: \n\n"
    printf "%-4s %-10s %-30s\n" "" "new" "Create a project in the root dir"
    printf "%-4s %-10s %-30s\n" "" "list" "List all the projects in the root dir"
    printf "%-4s %-10s %-30s\n" "" "open" "Opens a project using the code command"
    printf "%-4s %-10s %-30s\n" "" "help" "Displays a list of available lab commands and their help strings."
}

command=$1

case $command in
    new) 
        shift # shift arguments to ignore command
        
        # Transform long options to short ones
        for arg in "$@"
        do
            shift
            case "$arg" in
                "--name") set -- "$@" "-n" ;;
                "--"*)    echo "illegal option" "$arg"; exit 1;;
                *)        set -- "$@" "$arg"
            esac
        done

        while getopts n: flag
        do
            case "${flag}" in
                n) 
                    name=${OPTARG}
                    create_project $name
                    exit 0;;
            esac
        done;;
    
    list) ls ${ROOT_DIR}; exit 0;;
    open) shift; code ${ROOT_DIR}/$1; exit 0;;
    help) usage;;
esac
