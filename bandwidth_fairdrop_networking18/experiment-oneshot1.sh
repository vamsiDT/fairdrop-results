WORK=$(pwd)
FILE=$DPDK_INPUT/flow_table.h
EXP=/home/vk/vpp_cpu_faidrop_experiments

cd $VPP_ROOT
git checkout -f bandwidth_fairdrop_networking18
sudo make wipe-release

for ALPHA in 1.0 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1;do
mkdir $WORK/NETWORKING_FAIRDROP_BW_"$ALPHA"
sed -i "s/^\(#define ALPHA \).*/\1$ALPHA/" $FILE
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/NETWORKING_FAIRDROP_BW_"$ALPHA"/
done

sudo killall vpp_main
sudo killall pktgen
$WORK/in_out_networking.sh > $WORK/in_out_networking.dat

echo "FINSISHED EXPERIMENT FOR NETWORKING"

cd $VPP_ROOT
git checkout -f bandwidth_fairdrop_act
sudo make wipe-release

for ALPHA in 1.0 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1;do
mkdir $WORK/ACT_FAIRDROP_BW_"$ALPHA"
sed -i "s/^\(#define ALPHA \).*/\1$ALPHA/" $FILE
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/ACT_FAIRDROP_BW_"$ALPHA"/
done

sudo killall vpp_main
sudo killall pktgen
$WORK/in_out_act.sh > $WORK/in_out_act.dat

echo "FINSISHED EXPERIMENT FOR ACT"

cd $VPP_ROOT
git checkout -f bandwidth_fairdrop_shadow
sudo make wipe-release

for ALPHA in 1.0 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1;do
mkdir $WORK/SHADOW_FAIRDROP_BW_"$ALPHA"
sed -i "s/^\(#define ALPHA \).*/\1$ALPHA/" $FILE
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/SHADOW_FAIRDROP_BW_"$ALPHA"/
done

sudo killall vpp_main
sudo killall pktgen
$WORK/in_out_shadow.sh > $WORK/in_out_shadow.dat

echo "FINSISHED EXPERIMENT FOR SHADOW"


cd $VPP_ROOT
git checkout -f bandwidth_fairdrop_shadowact
sudo make wipe-release

for ALPHA in 1.0 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1;do
mkdir $WORK/SHADOWACT_FAIRDROP_BW_"$ALPHA"
sed -i "s/^\(#define ALPHA \).*/\1$ALPHA/" $FILE
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/SHADOWACT_FAIRDROP_BW_"$ALPHA"/
done

sudo killall vpp_main
sudo killall pktgen
$WORK/in_out_shadowact.sh > $WORK/in_out_shadowact.dat

echo "FINSISHED EXPERIMENT FOR SHADOWACT"

