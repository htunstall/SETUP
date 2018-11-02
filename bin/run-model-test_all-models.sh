#!/bin/bash
usage="$(basename $0) structure [label (default SiC)]-- Runs a specific structure through all the models in the models directory"
git_repo_path="/storage/chem/msufgx/postgrad/software/testing-framework"

# Get options
while getopts 'h' option; do
   case "$option" in
      h) echo "$usage"
         exit
         ;;
     \?) echo "Invalid Option: -$OPTARG"
         exit 1
         ;;
   esac
done

# Initialise variables
models_path="$(pwd)/../models"
scripts_path="$git_repo_path/scripts/"
basename=$(basename $(pwd))
label="SiC"
if [ "$2" ]; then
   label=$2
fi

if [ "$1" ]; then
   # If we're in the correct directory
   if [ "$basename" == "run_dir" ]; then
      # If we're in a singularity container
      if [ "$SINGULARITY_CONTAINER" ]; then
         echo "Settings: Label="$'\e[1m'$label$'\e[0m'" - Structure="$'\e[1m'$1$'\n\e[0m'
         # For each file/dir in the models dir
         for dir in $models_path/*; do
            # If it is a dir NOT a file
            if [ -d "$dir" ]; then
               # Get the current model name
               cur_model_name=$(basename $dir)

               # Run the test
               echo "Runnung '"$'\e[1m'$cur_model_name$'\e[0m'"'"
               $(run-model-test.py -s $label $cur_model_name $1 > .tmp.out)
            fi
         done
         rm -f .tmp.out
      # Else we are not in a container
      else
         echo "$usage"$'\n\n\033[31m\e[1mYou are not in a singularity container! Exiting.\e[0m'
      fi
   # If the user is not in "run_dir"
   else
      echo "$usage"$'\n\n\033[31m\e[1mYou are not in the testing directory! Exiting.\e[0m'
   fi
else
   echo "You have not defined a structure as arument 1"
fi
