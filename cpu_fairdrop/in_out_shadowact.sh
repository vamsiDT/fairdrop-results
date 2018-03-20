WORK=/home/vk/FAIRDROP_CPU_MASTER
i=350;while [[ $i -le 7000 ]];do cat $WORK/SHADOWACT_FAIRDROP_CPU_$i/plots/in_out.dat | awk -v a=$i '{print a"\t"$1"\t"$2}';i=$(( $i+350 ));done
