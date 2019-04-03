#!/bin/bash
# Version 1.2
# --Color added
# --Bug fixed at the list generator for node names that are used
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the Common Development
# and Distribution License Version 1.0 (the "License").
#
# You can obtain a copy of the license at
# http://www.opensource.org/licenses/CDDL-1.0.  See the License for the
# specific language governing permissions and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each file and
# include the License file in a prominent location with the name LICENSE.CDDL.
# If applicable, add the following below this CDDL HEADER, with the fields
# enclosed by brackets "[]" replaced with your own identifying information:
#
# Copyright (c) 2017, Berk Onat.  All rights reserved.
#
# CDDL HEADER END
#
# [Copyright (c) 2017-2019, Berk Onat.  All rights reserved.]
# This script displays available nodes using SLURM resource manager

if [ -z "$1" ]; then
me=`whoami`
else
me="$1"
fi
runnodes=`squeue -u $me | awk 'NR>1{print $8}' | grep -v "("`

strlist=`echo "$runnodes" | sed 's/\[\([^]]*\)\]*/\1/g' | awk -F"," '{for(i=1;i<=NF;i++) {print $i}}' | awk 'NR>0{if($0 ~ /^[A-z]/){l=substr($0, 0, 1);print $0;}else{printf "%s%s\n",l,$0}}'`
seqlist=`echo "$runnodes" | sed 's/\[\([^]]*\)\]*/\1/g' | awk -F"," '{for(i=1;i<=NF;i++) {print $i}}' | awk 'NR>0{if($0 ~ /^[A-z]/){l=substr($0, 0, 1);print $0;}else{printf "%s%s\n",l,$0}}' | awk 'NR>0{if ($0 ~ /^.*\-/){l=substr($0, 2, length($0));s=substr($0,1,1);printf "%s %s \n",s,l;}}' | sed -r 's/[-]+/ /g' | awk '{printf "%s\n",$0}'`

if [ -z "$seqlist" ]; then
nodelist=`echo -n "${strlist}" | grep -v "-" | tr '\n' ' ' | tr ' ' '|' | awk '{l=substr($0,0,length($0)-1); print l}'` 
else
seqlabel=($(echo "$seqlist" | awk '{printf "%s ",$1}'))
seqnum=($(echo "$seqlist" | awk '{printf "%s %s ",$2,$3}'))

nodelist=`echo -n "${strlist}" | grep -v "-" | tr '\n' ' ' | tr ' ' '|' | awk '{l=substr($0,0,length($0)-1); print l}'`
if [ -z "$nodelist" ]; then
nodelist="f000"
fi
i=0
j=1
l=0
for s in "${seqlabel[@]}"; 
do
nodelist=`echo -n "${nodelist}$(echo -n "$(seq ${seqnum[$i]} ${seqnum[$j]} | awk 'NR>0{for(i=1;i<=NF;i++){printf "\n'"${seqlabel[$l]}"'%03d",$i}}')" | grep -v "-" | tr '\n' ' ' | tr ' ' '|' | awk '{l=substr($0,0,length($0)-1); print l}')"` 
let "i= $i + 2"
let "j= $j + 2"
let "l= $l + 1"
done
fi

if [ -z "$nodelist" ]; then
nodelist="f000"
fi

scontrol show nodes | grep -A8 -e "NodeName" | grep -v "BootTime=" | grep -v "Partitions=" | grep -v "Gres" | grep -v "NodeAddr" | grep -v "Watts" | grep -v "^--" | sed "s/OS=Linux //g" | awk 'BEGIN{FS=" |="; OFS="\t";
printf " \033[1mNode\t\tCPU_Avail  CPU_Used  CPU_Total  Load     Mem(G)  FreeM(%) Swap(G) Status\033[0m\n"} 
NR>0 && NR%4==1 {
     if ($2 ~ /'"$nodelist"'/){
         printf " \033[4m\033[1m%s\033[0m",$2
     } else {
         printf " %s",$2
     }
     if (length($2)<24) {
         printf "    "
     }
} 
NR>0 && NR%4==2 {
     if ($9-$5>0) {
          printf "\t\033[32m%s\033[0m\t   %s\t     %s",$9-$5,$5,$9
     } else { 
          printf "\t\033[31m%s\033[0m\t   %s\t     %s",$9-$5,$5,$9
     }
     hot = $5+0.5
     cold = $5-0.6
     if ($11 ~ /N/) {
          printf "\t        \033[31m%s\033[0m",$11
     } else if ($11>hot) {
          printf "\t        \033[93m%s\033[0m",$11
     } else if ($11<cold) {
          printf "\t        \033[96m%s\033[0m",$11
     } else if ($11<hot && $11>cold) {
          printf "\t        %s",$11
     } else { 
          printf "\t        \033[31m%s\033[0m",$11
     } 
} 
NR>0 && NR%4==3 { 
     mem = $5/1000.0
     printf "\t%6.2f",mem
     freemem=$9/1000.0
     freeperc=100.0*(freemem/mem)
     if (freeperc<10){
         printf "\t\033[31m%6.2f\033[0m",freeperc
     } else {
         printf "\t%6.2f",freeperc
     }
} 
NR>0 && NR%4==0 { 
     if ($9/1000<5) {
         printf "\t\033[31m%6.2f\033[0m",$9/1000
     } else {
         printf "\t%6.2f",$9/1000
     }
     if ($5 ~ "ALLOCATED") {
         printf "\t  \033[34m%s\033[0m\n","ALLOC"
     } else if ($5 ~ "IDLE") {
         printf "\t  \033[32m%s\033[0m\n",$5
     } else if ($5 ~ "MIXED") {
         printf "\t  \033[35m%s\033[0m\n",$5
     } else {
         printf "\t  \033[31m%s\033[0m\n",$5
     }
}' 

