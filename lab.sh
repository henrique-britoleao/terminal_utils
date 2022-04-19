#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/.labrc

function create_project {
    local projects_dir=${ROOT_DIR}/$1 
    mkdir -v -p $projects_dir/src # create folder
    # add gitignore
    cat ${SCRIPT_DIR}/ignore.template > ${projects_dir}/.gitignore 
    # add setup files
    cat ${SCRIPT_DIR}/pyproject_toml.template > ${projects_dir}/pyproject.toml
    cat ${SCRIPT_DIR}/setup_cfg.template > ${projects_dir}/setup.cfg
    # add empty readme
    cd $projects_dir && touch README.md 
    git init 
    code $projects_dir # open code
}

function usage {
    printf "usage: lab command ...\n\n"
    printf "lab is a tool for creating and managing python projects.\n\n"
    printf "Options:\n\n"
    printf "positional arguments: \n\n"
    printf "%-4s %-10s %-30s\n" "" "new" "Create a project in the root dir"
    printf "%-4s %-10s %-30s\n" "" "list" "List all the projects in the root dir"
    printf "%-4s %-10s %-30s\n" "" "open" "Opens a project using the code command"
    printf "%-4s %-10s %-30s\n" "" "help" "Displays a list of available lab commands and their help strings."
}

function usage_new {
    printf "usage: lab new ...\n\n"
    printf "'new' is a command used to create new data science projects.\n\n"
    printf "Options:\n\n"
    printf "required arguments: \n\n"
    printf "%-4s %-10s %-30s\n" "" "-n/--name" "Name to be assigned to project"
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
                    name=${OPTARG};;
                *) echo ""; exit 1;;
            esac
        done

        if [ -z "$name" ]
        then
            echo "The argument -n is mandatory"; usage_new ; exit 1
        else
            create_project $name; exit 0
        fi;;
    
    list) ls ${ROOT_DIR}; exit 0;;
    open) shift; code ${ROOT_DIR}/$1; exit 0;;
    help) usage ; exit 0;;
    *) echo "lab: Command not found"; usage ; exit 1;;
esac
