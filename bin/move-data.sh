#!/bin/bash
usage="${0##*/} [options] -- Moves all non-default files to the raw-data directory:
   Options:
     -h        Displays this help
     -d        Deletes all non-default files in the directory (Takes precedence over the -o arg)
     -o        Move data with overwrite
     -f        Force overwrite without prompting"
git_repo_path="/storage/chem/msufgx/postgrad/software/SiC-framework"

# Default to not delete files in the directory
delete=False
overwrite=False
force=False

# Get options
while getopts 'hdof' option; do
   case "$option" in
      h) echo "$usage"
         exit
         ;;
      d) delete=True
         ;;
      o) overwrite=True
         ;;
      f) force=True
         ;;
     \?) echo "Invalid Option: -$OPTARG"
         exit 1
         ;;
   esac
done

# Initialise variables
data_path="$git_repo_path/raw-data"
cwd=$(pwd)
basename=${cwd##*/}

# If we're in the correct directory
if [ "$basename" == "run_dir" ]; then
   # If the hidden directory doesn't exist make it
   if [ ! -d "$cwd/.default-files" ]; then
      mkdir .default-files
   fi
   # Move the default files to a safe directory
   mv default_* .default-files
   mv test.bugs_script* .default-files

   if [ "$delete" == True ]; then
      if [ "$force" == True ]; then
         rm -f *
      else
         rm -i *
      fi
   else
      # For each *.json file in the testing directory
      for filename in ./*.json; do
         # If the json file exists
         if [[ (-f $data_path/$filename) && "$overwrite" == False ]]; then
            echo "Data relating to '$filename' not moved as it already exists in raw-data. If you wish to overwrite data please use -o"
         else
            # Cut of run_ by removeing upto the first "_" character
            general_filename=${filename#*/}
            # Cut everythin after the last "-" character
            general_filename=${general_filename%-*}

            if [[ ("$overwrite" == True) && "$force" == True ]]; then
               mv -f *$general_filename* $data_path
            else
               mv -i *$general_filename* $data_path
            fi

            echo "Data files for '*$general_filename*' moved to '/raw-data'"
         fi
      done
   fi

   # Move the default files back here
   mv .default-files/* ./

# If the user is not in "run_dir"
else
   echo "$usage"$'\n\n\033[31m\e[1mYou are not in the testing directory! Exiting.\e[0m'
fi
