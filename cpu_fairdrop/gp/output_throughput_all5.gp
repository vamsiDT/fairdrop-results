#! xgp flow_pps.dat
# Created the Fri Dec  8 02:30:12 CET 2017 with:
#   ____________________________
#  /                            \
# /        xgp        __________/
# \__________________/.:nonsns:.
#
 
#-------------------------------------
# SHAPES:
# (c)ircle  (t)riangle (i)nv.tri.
#           (d)iamond  (s)quare
# FILLING:
# (f)illed  (o)paque  (e)mpty (default)
#-------------------------------------
   s=4  ; es=s  ; fs=s+1 ; os=s+66
   c=6  ; ec=c  ; fc=c+1 ; oc=os+1
   t=8  ; et=t  ; ft=t+1 ; ot=oc+1
   i=10 ; ei=i  ; fi=i+1 ; oi=ot+1
   d=12 ; ed=d  ; fd=d+1 ; od=oi+1
   p=14 ; ep=p  ; fp=p+1 ; op=od+1
#-------------------------------------
#  e.g.:  
#  empty circles vs filled squares
#  plot "file" u 1:3 w p pt ec, 
#           "" u 1:4 w lp pt fs
#-------------------------------------

#Happy gnuplotting


set out "output_throughput_all5.png"
set term png font "Times,10"
#set pointsize 1.25

set key outside
#set ylabel "Per flow rate [pps]"
set title "Comparison between different optimizations in the implementation of CPU Fairdrop Algorithm\n{Overall VPP Throughput}\n{20 flows with 15 ip4 flows and 5 flows of weight 350*(WEIGHT FACTOR)}"
set xlabel "Weight Factor"
set xtics 1
set boxwidth 0.15
set style fill solid
#set ytics nomirror
#set y2tics
#set yrange [0:5]
#set y2range [0:6000]
set ylabel "Overall Output Throughput VPP MPPS"
#set y2label "Flow Weight"
#set format y "%.t^.10^%T"
#set ytics 200000
#set yran [1e3:]
#min(a,b)=a<b?a:b
#stats 	'flow_pps.dat'	every ::1 using 1 nooutput
#total=int(STATS_sum)
#print("Total Throughput")
#print(total)
#f(x)=total
set yrange [0:10]

plot \
'/home/vk/FAIRDROP_CPU_MASTER/in_out_networking5.dat'	u ($0+1-0.30):($3/1000000)   	t 'Networking'  axes x1y1 with boxes lc rgb "black",	\
'/home/vk/FAIRDROP_CPU_MASTER/in_out_shadow5.dat'    u ($0+1-0.15):($3/1000000)      t 'Shadow'  axes x1y1 with boxes lc rgb "brown",    \
'/home/vk/FAIRDROP_CPU_MASTER/in_out_act5.dat'    u ($0+1):($3/1000000)      t 'Act'  axes x1y1 with boxes lc rgb "blue",    \
'/home/vk/FAIRDROP_CPU_MASTER/in_out_shadowact5.dat'    u ($0+1+0.15):($3/1000000)      t 'Shadow-Act'  axes x1y1 with boxes lc rgb "0x2F4F4F",    \
'/home/vk/FAIRDROP_CPU_MASTER/in_out_taildrop5.dat'  u ($0+1+0.30):($3/1000000)	t 'Taildrop'   axes x1y1 with boxes lc rgb "violet"
#'flow_pps.dat'  u ($0+1+0.25):(f($1)/1000000)           t 'Per Flow Throughput'  axes x1y1 with boxes
