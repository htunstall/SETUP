#!/bin/bash
if [[ ("$1" = 2 || "$1" = 3) && "$2" ]]; then
    ~/anaconda$1/bin/${@:2}
else
    echo "Usage: [python version] [executable] [optional arguments]"
fi
