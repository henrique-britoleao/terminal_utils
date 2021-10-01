#!/bin/bash

function create_project () {
    local projects_dir=~/Documents/projects/$1
    mkdir -p ${projects_dir}/bin 
    cat ./ignore.template >> ${projects_dir}/.gitignore
    cd $projects_dir && touch README.md
    git init
    code $projects_dir
}

command=$1

case $command in
    new) 
        shift # shift arguments to ignore command
        while getopts n: flag
        do
            case "${flag}" in
                n) 
                    name=${OPTARG}
                    create_project $name;;
            esac
        done;;
    
    open) echo "open";;
    *) echo "lab: '$command' command not found"
esac
