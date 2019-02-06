#!/bin/bash
#-----------------------------------------------------------------------
# Interactive shell settings
#-----------------------------------------------------------------------
if [ "$PS1" ]; then
   #-------------------------------------------------------------------
   # Additions to the PATH
   #-------------------------------------------------------------------
   export PATH=$PATH:~/bin

   #-------------------------------------------------------------------
   # Grab the group being used currently
   #-------------------------------------------------------------------
   export GROUP=$(groups | awk '{print $1}')

   #-------------------------------------------------------------------
   # Aliases
   #-------------------------------------------------------------------
   # Load general aliases and functions
   if [ -f ~/SETUP/dot/aliases.bash ]; then
         . ~/SETUP/dot/aliases.bash
   fi

   # If user specific aliases are found, load them
   if [ -f ~/SETUP/dot/users/${USER}.bash ]; then
         . ~/SETUP/dot/users/${USER}.bash
   fi

   #-------------------------------------------------------------------
   # Check to see if we are in a singularity container
   #-------------------------------------------------------------------
   sing_str=$(env | grep SINGULARITY_CONTAINER)
   sing_img_name=${sing_str#*=}
   if [ "$SINGULARITY_CONTAINER" ]; then
      # We're in singularity; place the running scripts dir on the PATH
      export PATH=$PATH:/storage/chem/$USER/postgrad/software/testing-framework/scripts
      add_str="\n\e[1mSingularity Container: \e[34m$sing_img_name"
   fi

   #-------------------------------------------------------------------
   # Set my prompt
   #-------------------------------------------------------------------
   PS1="$add_str\n\e[01;36m\u.$GROUP\e[00m \e[01;37m(\A)\e[00m\n\e[01;35m\h\e[00m:\e[01;32m\w\e[00m\n[\!] $ "
   PS2=""

   #-------------------------------------------------------------------
   # Set my gnome titles
   #-------------------------------------------------------------------
   PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME} | ${PWD/#$HOME/~}"; echo -ne "\007"'

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
# vim:ts=8:sw=4:et
