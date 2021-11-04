# Project Manager Terminal Utils

![version](https://img.shields.io/badge/version-0.0.1-blue)

This project aims at creating a terminal toolset to facilitate the creation and
management of python projects. 

The code creates a terminal command `lab` which has the following functionalities:

- new: creates a new folder with a predetermined directory structure
- list: lists the names of created projects 
- open: uses VScode `code` terminal interface to open the project folder

## Setup

The util can be setup by cloning this repo:

```{bash}
git clone https://github.com/henrique-britoleao/terminal_utils.git
```

and then running the setup script from within the project's root directory.

```{bash}
bash setup.sh
```

## Config

The tool's configurations can be set in the `.labrc` file.
