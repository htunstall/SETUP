#!/bin/bash

if [ "$1" ] && [ "$2" ]; then
    echo "scp msufgx@barbagallo.csc.warwick.ac.uk:${1} ${2}"
else
    echo "You need to specify a source and destination as \$1 and \$2!"
fi
