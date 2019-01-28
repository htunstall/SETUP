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
##H
##H------------------------------------------------------------------------
##H Other Aliases
##H------------------------------------------------------------------------
##H
alias qwatch="watch -n 1 squeue -l -u tunstall"
##H
##H---------------------------------------------------------------------------
##H SSH Alias'
##H---------------------------------------------------------------------------
##H
##H
##H--------------------------------------------------------------------------
##H Additions to the PATH
##H--------------------------------------------------------------------------
##H
##H--------------------------------------------------------------------------
##H Modules to load
##H--------------------------------------------------------------------------
#H========================================================================
