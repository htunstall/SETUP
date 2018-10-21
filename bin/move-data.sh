#!/bin/bash
usage="${0##*/} [dir_name] [-h] -- Where [dir_name] will be created in the below folders and all test data will be moved to the sub-folder in raw-data:

   'SiC-framework/raw-data/[dir_name]' and
   'SiC-framework/analysis/output/graphs/[dir_name]'"
username="msufgx"
git_repo_path="/storage/chem/$username/postgrad/software/SiC-framework"

while getopts 'h' option; do
   case "$option" in
      h) echo "$usage"
         exit
         ;;
     \?) echo "$usage"
         exit 1
         ;;
   esac
done

# Are we given the correct arguments?
if [ -z "$1" ]; then
   echo "$usage"
else
   data_path="$git_repo_path/raw-data/$1"
   out_path="$git_repo_path/analysis/outputs/graphs/$1"

   cwd=$(pwd)
   basename=${cwd##*/}
   # If we're in the correct directory
   if [ "$basename" == "run_dir" ]; then
      # If the dir we want to create exists then append "_1" to both paths
      #   and the input dirname variable
      append="False"
      if [ -d "$data_path" ]; then
         append="True"
         data_path="${data_path}_1"
         out_path="${out_path}_1"
      fi
      # Make the two output directories
      mkdir $data_path
      mkdir $out_path

      # If the hidden directory doesn't exist make it
      if [ ! -d "$cwd/.default-files" ]; then
         mkdir .default-files
      fi

      # Move the default files to a safe directory
      mv default_* .default-files
      mv test.bugs_script* .default-files

      # Move the rest of the files to the new dir
      mv * $data_path

      # Move the default files back here
      mv .default-files/* ./
      if [ "$append" == "False" ]; then
         echo "Data files moved to '/raw-data/$1'"
      else
         echo "Data files moved to '/raw-data/${1}_1'"
      fi
   else
      echo "$usage"$'\n\033[31m\e[1mYou are not in the testing directory! Exiting.\e[0m'
   fi
fi
