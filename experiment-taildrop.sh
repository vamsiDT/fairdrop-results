ALPHA=1.0
WORK=$(pwd)
#FILE=$DPDK_INPUT/flow_table.h
FILE=$VPP_ROOT/src/vnet/ip/fifo.h
EXP=/home/vk/vpp_cpu_faidrop_experiments
#until  [ $(echo $ALPHA | awk -F "." '{print $1}') -gt 0 -a $(echo $ALPHA | awk -F "." '{print $2}') -gt 0 ]
#for ALPHA in 1.0 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1;do
for ALPHA in 0.1;do
mkdir $WORK/TAILDROP_BW_"$ALPHA"
sed -i "s/^\(#define ALPHA \).*/\1$ALPHA/" $FILE
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/TAILDROP_BW_"$ALPHA"/

done

sudo killall vpp_main
sudo killall pktgen
$WORK/in_out_taildrop.sh > $WORK/in_out_taildrop.dat

echo "FINSISHED EXPERIMENT"
