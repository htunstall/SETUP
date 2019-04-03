#!/bin/bash
#%#---------------------------------------------------------------------
#%# $Id$
#%#
#%# File: /home/chem/msufgx/SETUP/dot/users/msufgx.bash
#%#
#%# @(#) Bash aliases for msufgx
#%#---------------------------------------------------------------------

###---------------------------------------------------------------------
### Key to the commenting conventions used in this file
###---------------------------------------------------------------------

      ### = Comments that will appear before a block that is the minimum
      ###   explanation required for the following code

###   #n# = More detailed comments that can be selected if required
      ###   Where 'n' is the level of detail:
      ###     1 = lowest  - a little extra info (typically notes),
      ###     9 = highest - so verbose as to be ridiculous!

###   #%# = Title information and vital information that really should stay
      ###   in a file regardless of what other comments are removed

###   #?# = During development this means I'm not sure whether this should be
      ###   included in the final version or not

###   ##H = Comment that can be used for building a help file (see below)
      #1#
      #1# NOTE: This commenting method allows you to generate a help file
      #1#             from this file by executing the following command
      #1#
      #1#       % sed -ne 's/^ *##H//p' < msufgx.bash > msufgx.help
      #2#
      #2# To make the help file readable and comprehend any special settings
      #2# based on machine type the help comments should note if a particular
      #2# alias applies ONLY under certain circumstances. i.e.
      #2#
      #2#    ##H
      #2#    ##H
      #2#    ##H USEFUL BSD4.3 PROGRAMS
      #2#    ##H ====================== (DomainOS ONLY)
      #2#    ### Quick way of getting at the BSD versions of 'head' & 'tail'
      #2#    #1#
      #2#    #1# The BSD version of 'tail' lets you tail more output than in
      #2#    #1# sys5.3
      #2#    #1#
      #2#    ##H head       - Access to the BSD4.3 'head' program
      #2#
      #2# There shuold be particular attention to the indentation of the help
      #2# information as it will be awful to read if things don't line up
      #2# correctly!  This is why there is so much space between the alias
      #2# name 'head' above and the description.
      #2#
      #3# This means that it is a good idea to keep the alias name as short
      #3# as possible.  Not only does this reduce the amount of typing that
      #3# is needed to execute the command but it give more room on the line
      #3# for the help description!

##############################################################################
### Help file header information
##############################################################################
##H NOTE: This file was automatically extracted from the RCS file:
##H
##H $Id$
##H
##H @(#) Help file for personal 'bash' aliases: 
##H                                      $HOME/SETUP/dot/users/msufgx.bash
##H---------------------------------------------------------------------------
##H
##H NOTE: Where '(path optional)' appears the default is the current directory
##H
##H===========================================================================
##H Additions by: Harry Tunstall
##H---------------------------------------------------------------------------
##H Directory Listing/Moving
##H---------------------------------------------------------------------------
##H
##H   The username variable is to enable easy sharing of the alias' file
##H    between the University of Warwick SCRPT user accounts
##H
##H  gts        - cd /storage/chem/$username/postgrad
##H                                          # Go to the storage directory
##H  gtgit      - cd /storage/chem/$username/postgrad/software
##H                                          # Go to the gits directory
##H  lf         - ls -logh --color=always    # List files
##H  laf        - ls -logha --color=always   # List all files
##H  lft        - ls -loghtr --color=always  # List files in reverse time order  
alias gts="cd /storage/chem/$USER/postgrad"
alias gtgit="cd /storage/chem/$USER/postgrad/software"
alias lf="ls -logh --color=always"
alias laf="ls -logha --color=always"
alias lft="ls -loghtr --color=always"

##H
##H-------------------------------------------------------------------
##H Check what server we're on 
##H-------------------------------------------------------------------
##H
#manpath=$(env | grep MANPATH)
#server=$(cut -d'/' -f3 <<< $manpath)
#echo $server
#if [[ "$server" == "share" ]]; then
##H
##H------------------------------------------------------------------------
##H Script Aliases
##H------------------------------------------------------------------------
##H
##H  shsing     - singularity_shell.sh       # SHell in SINGularity
##H  pya        - python_anaconda.sh         # PYthon Anaconda 
##H  asc        - ase_structure_converter.py # Ase Struc. Converter
##H  clean      - clean-test-dir.sh          # Cleans test directory
##H  start-jnbk-svr - starts a detached screen running a jup-nbk
##H  kill-jnbk-srv  - kills the screen running the jupyter notebook server
alias shsing="singularity_shell.sh"
alias pya="python_anaconda.sh"
alias asc="ase_structure_converter.py"
alias clean="source ~/bin/clean-test-dir.sh"
alias start-jnbk-svr="jupyter_notebook_server_start.sh"
alias kill-jnbk-svr="screen -X -S jnbk_server quit"

##H
##H------------------------------------------------------------------------
##H Other Aliases
##H------------------------------------------------------------------------
##H
##H  tunnel-ssh
alias tunnel-ssh="ssh -N -f -L localhost:8888:localhost:8888 msufgx@barbagallo.csc.warwick.ac.uk"
alias tunnel-status="ps aux | grep ssh; echo 'kill <process_id> -- where process_id is the second column'"


##H
##H------------------------------------------------------------------------
##H HPC Alias'
##H------------------------------------------------------------------------
##H
alias qwatch_fat="watch -n 1 squeue -p fat -l S P,u,j"

##H
##H--------------------------------------------------------------------------
##H Additions to the PATH
##H--------------------------------------------------------------------------
##H  If we are not in a sungularity container, add to the path and load modules
if [ ! "$SINGULARITY_CONTAINER" ] && [ "$HOSTNAME" = "barbagallo.csc.warwick.ac.uk" ]; then

    ##H  Turbomole scripts added to path
    export PATH=$PATH:$HOME/Turbomole/TURBOMOLE/bin/em64t-unknown-linux-gnu:/home/chem/msufgx/Turbomole/TURBOMOLE/scripts

    ##H  Turbomole TURBODIR exported to env
    export TURBODIR=$HOME/Turbomole/TURBOMOLE

    ##H  Ovito bin added to path
    export PATH=$HOME/ovito-2.9.0-x86_64/bin/:$PATH

    ##H  Mendeley Desktop added to path
    export PATH=$HOME/programs/mendeleydesktop-1.19.2-linux-x86_64/bin:$PATH

    ##H  LAMMPS script path
    export PATH=/storage/chem/msufgx/postgrad/software/SiC-framework/testing-dir/lammps/scripts/lammps:$PATH

    ##H
    ##H--------------------------------------------------------------------------
    ##H Modules to load
    ##H--------------------------------------------------------------------------
    ##H  Loaded VMD
    ##H  Loaded GCC
    module load VMD/1.9.1
    module load intel/2018.1.163-GCC-6.4.0-2.28
    module load binutils/2.28
    module load impi/2018.1.163
fi
#module load QuantumESPRESSO
##H Otherwise we're on tinnis/orac
#else
#   module load GCC/6.4.0-2.28
#   module load OpenMPI/2.1.2
#   module load OpenBLAS/0.2.20
#fi
#H========================================================================
