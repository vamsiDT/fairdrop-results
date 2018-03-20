WEIGHT=350
WORK=$(pwd)
FILE=$DPDK_INPUT/flow_table_cpu.h
EXP=/home/vk/vpp_cpu_faidrop_experiments
cd $VPP_ROOT
git checkout -f origin/fairdrop_cpu_networking18
sudo make wipe-release
until [ $WEIGHT -gt 7000 ]
do
mkdir $WORK/NETWORKING5_FAIRDROP_CPU_"$WEIGHT"
sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment.sh
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/NETWORKING5_FAIRDROP_CPU_"$WEIGHT"/

WEIGHT=$(python -c "print($WEIGHT+350)")
done

sudo killall vpp_main
sudo killall pktgen

$WORK/in_out_networking5.sh > $WORK/in_out_networking5.dat
echo "FINSISHED EXPERIMENT for NETWORKING 18"

WEIGHT=350
cd $VPP_ROOT
git checkout -f origin/fairdrop_cpu_act
sudo make wipe-release
until [ $WEIGHT -gt 7000 ]
do
mkdir $WORK/ACT5_FAIRDROP_CPU_"$WEIGHT"
sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment.sh
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/ACT5_FAIRDROP_CPU_"$WEIGHT"/

WEIGHT=$(python -c "print($WEIGHT+350)")
done

sudo killall vpp_main
sudo killall pktgen

$WORK/in_out_act5.sh > $WORK/in_out_act5.dat
echo "FINSISHED EXPERIMENT for ACT"

WEIGHT=350
cd $VPP_ROOT
git checkout -f origin/fairdrop_cpu_shadow
sudo make wipe-release
until [ $WEIGHT -gt 7000 ]
do
mkdir $WORK/SHADOW5_FAIRDROP_CPU_"$WEIGHT"
sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment.sh
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/SHADOW5_FAIRDROP_CPU_"$WEIGHT"/

WEIGHT=$(python -c "print($WEIGHT+350)")
done

sudo killall vpp_main
sudo killall pktgen

$WORK/in_out_shadow5.sh > $WORK/in_out_shadow5.dat
echo "FINSISHED EXPERIMENT for SHADOW"

WEIGHT=350
cd $VPP_ROOT
git checkout -f origin/fairdrop_cpu_shadowact
sudo make wipe-release
until [ $WEIGHT -gt 7000 ]
do
mkdir $WORK/SHADOWACT5_FAIRDROP_CPU_"$WEIGHT"
sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment.sh
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/SHADOWACT5_FAIRDROP_CPU_"$WEIGHT"/

WEIGHT=$(python -c "print($WEIGHT+350)")
done

sudo killall vpp_main
sudo killall pktgen

$WORK/in_out_shadowact5.sh > $WORK/in_out_shadowact5.dat
echo "FINSISHED EXPERIMENT for SHADOWACT"


WEIGHT=350
cd $VPP_ROOT
git checkout -f origin/busyloops_nofairdrop
sudo make wipe-release
until [ $WEIGHT -gt 7000 ]
do
mkdir $WORK/TAILDROP5_CPU_"$WEIGHT"
sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment.sh
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/TAILDROP5_CPU_"$WEIGHT"/

WEIGHT=$(python -c "print($WEIGHT+350)")
done

sudo killall vpp_main
sudo killall pktgen

$WORK/in_out_taildrop5.sh > $WORK/in_out_taildrop5.dat
echo "FINSISHED EXPERIMENT for SHADOWACT"

