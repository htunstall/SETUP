# SETUP
The setup and configuration files for unix systems

#### Installation ####
1) Place the SETUP folder in your root directory
2) Create symbolic from `~/SETUP/dot/` to your root directory for the bashrc with the following commands
    1) `cd ~ ` # Make sure we're in the root directory
    2) `ln -s SETUP/dot/profile .profile ` # N.B If you already have a .bashrc/.profile you will need to rename it with a suffix .old and then merge the contents of .bashrc with the startup.bash file (located in SETUP/dot)
    3) `ln -s SETUP/dot/bashrc .bashrc`
    4) `ln -s SETUP/bin ./bin`

Make sure you change the username variable (near the top of the aliases.bash file) to your username! And feel free to change the aliases/scripts as you see fit. Share and enjoy!
