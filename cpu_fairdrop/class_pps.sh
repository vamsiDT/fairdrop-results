i=350
#k=80000
DIR=$(pwd)
j=$2
while [[ $i -le 7000 ]];do
#for j in FAIRDROP_CPU;do
if [[ $1 -eq 1 ]]; then
CLASS_1=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 3 | tail --lines 1| awk '{print $1}')
CLASS_2=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 1 | awk '{print $1}')
CLOCK_1=$(python -c "print($CLASS_1 * 350)")
CLOCK_2=$(python -c "print($CLASS_2 * $i)")

SUM=$(python -c "print($CLASS_1+$CLASS_2)")
SQ=$(python -c "print(($CLASS_1*$CLASS_1)+($CLASS_2*$CLASS_2))")
JAIN=$(python -c "print(($SUM*$SUM)/(2*$SQ))")

SUM1=$(python -c "print($CLOCK_1+$CLOCK_2)")
SQ1=$(python -c "print(($CLOCK_1*$CLOCK_1)+($CLOCK_2*$CLOCK_2))")
JAIN1=$(python -c "print(($SUM1*$SUM1)/(2*$SQ1))")
echo -e "WEIGHT\t$i\tThroughput_Fairness_index\t$JAIN\tCycles_Fairness_index\t$JAIN1"
else
D=$DIR/"$j"_"$i"/plots
cat $D/flow_pps.dat | awk -v x=$i 'BEGIN{sum=0;sum1=0; sq=0;sq1=0}{ sum+=($1);sum1+=($1*$3); sq+= (($1)*($1)); sq1+=(($1*$3)*($1*$3)); }END{ print ( "WEIGHT\t",x,"\tThroughput_Fairness_index\t", (sum*sum)/(NR*sq),"\tCycles_Fairness_index\t", (sum1*sum1)/(NR*sq1) )}'
#cat $D/flow_pps.dat | awk -v x=$i 'BEGIN{sum=0; sq=0;}{ sum+=($1*$3); sq+= (($1*$3)*($1*$3)); }END{ print ( "WEIGHT\t", x, "Cycle Fairness index\t", (sum*sum)/(NR*sq) )}'
fi
#done
i=$(( $i+350 ))
done
