i=350
DIR=$(pwd)
while [[ $i -le 7000 ]];do
for j in $1;do
TOTAL=$(cat $DIR/"$j"_"$i"/pktgenstats.dat | awk '{print $6}')
RX_MISS=$(cat $DIR/"$j"_"$i"/showint.dat | grep "rx-miss" |awk '{print $2}')
VPP_OUTPUT=$(cat $DIR/"$j"_"$i"/showint.dat | grep "TenGigabitEthernet84/0/1" |awk '{print $6}')
VPP_INPUT=$(( $TOTAL-$RX_MISS ))
VPP_DROP=$(( $VPP_INPUT-$VPP_OUTPUT ))
#VPP_INPUT=$(cat $DIR/"$j"_"$i"/showint.dat | grep "TenGigabitEthernet84/0/0" |awk '{print $6}')
#VPP_DROP=$(cat $DIR/"$j"_"$i"/showint.dat | grep "drops" |awk '{print $2}' | head --lines 1)

#TOTAL=$(( $RX_MISS+$VPP_INPUT))
echo -e "WEIGHT:\t$i\t$j\tRX_MISS:\t$RX_MISS\tVPP_INPUT:\t$VPP_INPUT\tVPP_DROP:\t$VPP_DROP\tVPP_OUTPUT\t$VPP_OUTPUT\tTOTAL:\t$TOTAL"
done
i=$(( $i+350 ))
done
