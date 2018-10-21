#%#---------------------------------------------------------------------
#%# $Id$
#%#
#%# File: /home/tunstall/SETUP/dot/aliases.bash
#%#
#%# @(#) Bash aliases
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
      #1#       % sed -ne 's/^ *##H//p' < .aliases.csh > .aliases.csh.hlp
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
##H @(#) Help file for personal 'bash' aliases: $HOME/SETUP/dot/aliases.bash
##H------------------------------------------------------------------------
##H
##H NOTE: Where '(path optional)' appears the default is the current directory
##H
##H========================================================================
##H Additions by: Harry Tunstall
##H------------------------------------------------------------------------
##H Directory Listing/Moving
##H------------------------------------------------------------------------
##H
##H  lf         - ls -logh --color=always    # List files
##H  laf        - ls -logha --color=always   # List all files
##H  lft        - ls -loghtr --color=always  # List files in reverse time order
alias lf="ls -logh --color=always"
alias laf="ls -logha --color=always"
alias lft="ls -loghtr --color=always"
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
##H------------------------------------------------------------------------
##H Other Aliases
##H------------------------------------------------------------------------
##H
##H  tunnel-ssh
alias tunnel-ssh="ssh -N -f -L localhost:8888:localhost:8888 msufgx@barbagallo.csc.warwick.ac.uk"
alias tunnel-ststus="ps aux | grep ssh; echo 'kill <process_id> -- where process_id is the second column'"
##H========================================================================
##H

##############################################################################
### Help file header information
##############################################################################
##H NOTE: This file was automatically extracted from the RCS file:
##H
##H $Id$
##H
##H @(#) Help file for personal 'bash' aliases: $HOME/SETUP/dot/aliases.bash
##H------------------------------------------------------------------------
##H
##H NOTE: Where '(path optional)' appears the default is the current directory

##H
##H------------------------------------------------------------------------
##H Saftey first
##H
##H mv         - mv -i
##H cp         - cp -i
##H rm         - rm -i
function cp()
{
    case $# in
        0)
            echo -e "\nINFO: Nothing to copy. Try providing a list of files..."
            echo -e "INFO: or try 'cp -h'\n"
        ;;

        1)
            if [ "$1" == "-h" ]; then
                echo -e "\n-- Personal function\n"
                echo -e "usage: cp [-h] [file | file dest | file*n dest]\n"
                echo    "    Copy files:"
                echo    "    -  1 argument  = copy file to current directory"
                echo    "    -  2 arguments = copy file to specitied destination"
                echo -e "    - >2 arguments = pass arguments directly to 'cp'\n"
            else
                /bin/cp -i $1 .
            fi
        ;;

        *)
            /bin/cp -i $*

    esac
}

alias mv='mv -i'
alias rm='rm -i'

##H
##H-----------------------------------------------------------------------
##H Common mis-spellings
##H-----------------------------------------------------------------------
##H gerp       - grep
##H jbos       - jobs
##H lll        - ll
##H mroe       - more
##H mkdri      - mkdir
##H pdw        - pwd
alias gerp=grep
alias jbos=jobs
alias lll=ll
alias mroe=more
alias mkdri=mkdir
alias pdw=pwd

##H
##H-----------------------------------------------------------------------
##H Shorthand
##H-----------------------------------------------------------------------
##H a          - alias
##H f          - find
##H m          - more
##H j          - jobs
##H l          - less
alias a=alias
alias f=find
alias m=more
alias j=jobs
alias l=less

##H pf         - print functions
function pf()
{
    if [ $# -ne 1 ] ; then
        typeset -f
    else
        typeset -f $1
    fi
}

##H
##H-----------------------------------------------------------------------
##H Environment helpers
##H-----------------------------------------------------------------------
##H envg       - grep environment settings
alias envg='env | grep -i'

##H psg        - Run 'ps' and 'grep' for word supplied
function psg()
{
    ps -efww | grep $1 | grep -v grep
}

##H
##H-----------------------------------------------------------------------
##H Directory based
##H-----------------------------------------------------------------------
##H ..         - cd ..
##H ,          - cd -
alias ..='cd ..'
alias ,='cd -'

##H cd         - 'cd' but if a file will truncate to the directory
function cd()
{
    unset switch
    if [ $# -eq 0 ] ; then
        builtin cd
    else
        if [ "$1" = "-L" ] || [ "$1" = "-P" ]; then
            switch="$1"
            shift
        elif [ "$1" = "-" ]; then
            builtin cd -
        fi

        if [ -d $1 ]; then
            builtin cd $1
        else
            builtin cd $(dirname $1)
        fi
    fi

}

##H ds         - dirs (with nice formatting)
##H pd         - pushd
##H go         - pushd +<#>
##H up         - pushd ..

alias ds='dirs |  awk '\''{i=0; do {printf ("%5d: %s\n", i, $(i+1));i++;} while (i < NF)}'\'''

function pd()
{
    if [ $# -ne 1 ] ; then
        pushd > /dev/null
        ds
    else
        pushd $1 > /dev/null
        ds
    fi
}

function go()
{
    if [ $# -ne 1 ] ; then
        ds
    else
        pushd +$1 > /dev/null
        ds
    fi
}

##H drop       - popd +<#>
function drop()
{
    if [ $# -ne 1 ] ; then
        popd > /dev/null
        ds
    else
        popd +$1 > /dev/null
        ds
    fi
}

alias up='pushd .. > /dev/null; ds'

##H
##H------------------------------------------------------------------------
##H Directory listing
##H------------------------------------------------------------------------
##H ll         - List files with the 'lsWithCommas' script
##H ll.        - List '.' files
##H ltr        - List files in reverse time order
#-K- alias lsWithCommas=lsWithCommas.pl
#-K- alias ll='lsWithCommas'
#-K- alias ll.='lsWithCommas -ldog .* --color=always'
#-K- alias ltr='lsWithCommas -ltrog   --color=always'

##H llt        - List files modified today
#-K- function llt()
#-K- {
#-K-     lsWithCommas.pl --color=never -log --time-style=+%Y-%m-%d \
#-K-         | grep "$(date +%Y-%m-%d)"
#-K- }

##H End        - List the last ten newest files (wildcard optional)
##H              If the first argument is -XX then use to return XX lines
#-K- function End()
#-K- {
#-K-     unset endCount
#-K-     unset argOne
#-K-     if [ $# -eq 1 ]; then
#-K-         argOne=${1##-}
#-K-         if [ "$1" == "-${argOne}" ]; then
#-K-             endCount=-${argOne}
#-K-             shift
#-K-         else
#-K-             endCount=-10
#-K-         fi
#-K-     else
#-K-         endCount=-10
#-K-     fi
#-K-     lsWithCommas -ltrog --color=always $* | tail ${endCount} 
#-K- }

##H lld        - List only directories in long format (path optional)
##H llf        - List only files       in long format (path optional)
#-K- alias lld='lsWithCommas -log --color=always | grep ^d'
#-K- alias llf='lsWithCommas -log --color=always | grep ^-'

##H
##H------------------------------------------------------------------------
##H Path info
##H-----------------------------------------------------------------------
##H path       - More readable form of the path output
function path()
{
    echo -e "\n"
    echo    "$PATH" \
        | sed -e 's/^/path = /' \
        | tr ':' '\n' \
        | awk '!/path/ {printf("       %s\n", $1)} /path/ {print}'
}

##H h          - Print history information:
##H              usage: h [-h] [search1] [search2]
##H              - no  arguments = all history
##H              - one argument  = grep for 'search1' in history
##H              - two arguments = grep for 'search2' then 'search2' in history
##H              - more than two arguments - use the first two as above
function h()
{
    case $# in
        0)
            history
        ;;

        1)
            if [ "$1" == "-h" ]; then
                echo -e "\n-- Personal function\n"
                echo    "usage: h [-h] [search1] [search2]"
                echo    "    Print history information:"
                echo    "    - no  arguments = all history"
                echo    "    - one argument  = grep for 'search1' in history"
                echo    "    - two arguments = grep for 'search2' then 'search2' in history"
                echo -e "    - more than two arguments - use the first two as above\n"
            else
                history | grep $1
            fi
        ;;

        *)
            history | grep $1 | grep $2


    esac

}

##H f.           - Find files starting below the current directory
function f.()
{
    if [ $# -eq 0 ] ; then
        echo "INFO: Nothing to do. Try providing a list of files..."
    else
        search=$1
        shift
        if [ $# -ge 1 ] ; then
            filter=$1
            find . -name "*${search}*" -print0 | xargs -0 /bin/ls -ladog | grep -i ${filter}
        else
            find . -name "*${search}*" -print0 | xargs -0 /bin/ls -ladog 
        fi
    fi
}

##H f.g          - Find files starting below the current directory and use a
##H                (case insensitive) search within them using an 'xargs' loop 
function f.g()
{
    if [ $# -eq 0 ] ; then
        echo "INFO: Nothing to do. Try providing a list of files..."
    else
        search=$1
        shift
        if [ $# -ge 2 ] ; then
            filter=$1
            lookIn=$2
            find . -name "*$search*" -print \
                | grep -i $filter \
                | xargs -n1 grep -Hi ${lookIn}
        else
            lookIn=$1
            find . -name "*$search*" -print \
                | xargs -n1 grep -Hi ${lookIn}
        fi
    fi
}

##H
##H Aliases for starting things
##H ===========================
##H title       - Set the shell title
function title()
{
    export PROMPT_COMMAND=
    echo -en "\033]0;$@\007"
}

##H stt         - Set the title of the shell (makes it easier to find...)
alias stt="title 'Tools (launch)'"

#-----------------------------------------------------------------------
# Screen connectivity helpers
#-----------------------------------------------------------------------
function scrr()
{
    screen -r $(screen -list | grep Detached | awk '{print $1}')
}

# vim: et sw=4 ts=4 ai tw=0
