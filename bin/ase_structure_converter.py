#!/home/chem/msufgx/anaconda3/bin/python
import argparse
import ase.io
import os.path

# Build the argument parser
parser = argparse.ArgumentParser(description="Quick python script to convert .cif (and other) files to another type, retaining unit cell data")

# Add the arguments
parser.add_argument("input", help="The input file to be converted")
# nargs (0 or 1 allowed arguments)
# default (the default value if the argument is not specified
parser.add_argument("--output", help="The ouptut file to be created", nargs="?")
parser.add_argument("--inputtype", help="The input file type (default .cif)", nargs="?", default="cif")
parser.add_argument("--outputtype", help="The output file type (default .extxyz)", nargs="?", default="extxyz")

# Take the arguments and create an object of them
args = parser.parse_args()

if not args.output:
  # Split on the file type seperator
  temp_str = args.input.split(".")
  # Replace the file type with the new output type
  temp_str[len(temp_str) - 1] = args.outputtype
  # Set the value of the new oupput filename
  args.output = ".".join(temp_str)

# Does the input file exist
if os.path.isfile(args.input):
  # Read in the given file as the given format
  atomlist = ase.io.read(args.input, format=args.inputtype)

  # If the output file exists
  overwrite = False
  if os.path.isfile(args.output):
    collect_ans = True
    while collect_ans:
      ans = input("The ouput file '{}' exists. Do you wish to overwrite it? (y/n): ".format(args.output)).lower()
      if ans == "y" or ans == "yes" or ans == "n" or ans == "no":
        collect_ans = False
    # If the user chooses to overwrite the file
    if ans == "y" or ans == "yes":
      overwrite = True
  
  # If the output file doesn't exist OR if we want to overwrite it
  if not os.path.isfile(args.output) or overwrite == True:
    if overwrite:
      print("Overwrinting the file '{}' with new data".format(args.output))
    else:
      print("Writing the file '{}'".format(args.output))

    # Do the conversion!
    # Read in the given file as the given format
    atomlist = ase.io.read(args.input, format=args.inputtype)
    # Write out the new format
    ase.io.write(args.output, atomlist, format=args.outputtype)

  # The user opted to not overwrite the file
  else:
    print("Aborting the process without saving an output file '{}'".format(args.output))

# The input file does NOT exist
else:
  print("The input file '{}' does not exist!".format(args.input))
