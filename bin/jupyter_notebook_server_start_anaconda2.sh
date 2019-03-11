#!/bin/bash
# If we're not in a screen session
if [ -z "$STY" ]; then
  # Creaste a screen session called "jnbk_server" and call this script again when inside
  exec screen -dmSt jnbk_server_2715 jnbk_server_2715 /bin/bash "$0" 
fi
# Commands to run inside the detached screen (N.B: after they 
#   have all completed the screen will close). To stop this
#   run the comand "exec bash" to start a bash ternimal, which
#   will keep the screen open
if [ "$GROUP" = "msufgx" ]; then
  cwd=/storage/chem/msufgx/postgrad/software/SiC-framework/analysis
else
  cwd="$HOME"
fi
$HOME/anaconda2/bin/jupyter notebook --notebook-dir=$cwd --no-browser --port=2715
#exec bash
