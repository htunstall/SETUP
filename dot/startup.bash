#!/bin/bash
#-----------------------------------------------------------------------
# Interactive shell settings
#-----------------------------------------------------------------------
if [ "$PS1" ]; then

    #-------------------------------------------------------------------
    # Additions to the PATH
    #-------------------------------------------------------------------
    export PATH=$PATH:~/Turbomole/TURBOMOLE/bin/em64t-unknown-linux-gnu:/home/chem/msufgx/Turbomole/TURBOMOLE/scripts
    export TURBODIR=~/Turbomole/TURBOMOLE
    export PATH=$PATH:~/bin

    #-------------------------------------------------------------------
    # Load Modules
    #-------------------------------------------------------------------
    module load VMD/1.9.1

    #-------------------------------------------------------------------
    # Check to see if we are in a singularity container
    #-------------------------------------------------------------------
    sing_str=$(env | grep SINGULARITY_CONTAINER)
    sing_img_name=${sing_str#*=}
    if [ "$SINGULARITY_CONTAINER" ]; then
        in_singularity=true
    else
        in_singularity=false
    fi


    #-------------------------------------------------------------------
    # Grab the group being used currently
    #-------------------------------------------------------------------
    export GROUP=$(groups | awk '{print $1}')

    #-------------------------------------------------------------------
    # Set my prompt
    #-------------------------------------------------------------------
    if [ "$in_singularity" = true ]; then
       add_str="\n\e[1mSingularity Container: \e[31m$sing_img_name"
    fi
    PS1="$add_str\n\e[01;36m\u.$GROUP\e[00m \e[01;37m(\A)\e[00m\n\e[01;35m\h\e[00m:\e[01;32m\w\e[00m\n[\!] $ "
    PS2=""


    #-------------------------------------------------------------------
    # Set my gnome titles
    #-------------------------------------------------------------------
    PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'

    #-------------------------------------------------------------------
    # Hack for history settings
    #-------------------------------------------------------------------
    #-K- export HISTIGNORE="&:[ ]*:exit"
    export HISTFILESIZE=1000
    shopt -s histappend

    #-------------------------------------------------------------------
    # Sort out the 'dircolors'
    #-------------------------------------------------------------------
    eval $(dircolors -b)

fi


# User specific aliases and functions
if [ -f ~/SETUP/dot/aliases.bash ]; then
        . ~/SETUP/dot/aliases.bash
fi

# vim:ts=8:sw=4:et
