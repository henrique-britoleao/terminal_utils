#!/bin/bash

function create_project () {
    local projects_dir=~/Documents/projects/$1 # TODO: Add config to change root dir 
    mkdir -p ${projects_dir}/bin 
    cat ./ignore.template > ${projects_dir}/.gitignore
    cd $projects_dir && touch README.md
    git init
    code $projects_dir
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
            esac
        done

        while getopts n: flag
        do
            case "${flag}" in
                n) 
                    name=${OPTARG}
                    create_project $name;;
            esac
        done;;
    
    open) echo "open";;
esac
