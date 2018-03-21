WORK=/home/vk/FAIRDROP_BW_MASTER
#for i in 0.1 0.4 0.6 1.0;do cat $WORK/FAIRDROP_BW_$i/plots/in_out.dat | awk -v a=$i '{print a"\t"$1"\t"$2}';done
for i in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0;do cat $WORK/TAILDROP_BW_$i/plots/in_out.dat | awk -v a=$i '{print a"\t"$1"\t"$2}';done
