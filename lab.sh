#!/bin/bash

source .labrc

function create_project () {
    local projects_dir=${ROOT_DIR}/$1 # TODO: Add config to change root dir
    mkdir -v -p $projects_dir/bin # create folder
    cat ./ignore.template > ${projects_dir}/.gitignore # add gitignore
    cd $projects_dir && touch README.md # add empty readme
    git init 
    code $projects_dir # open code
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
esac
