# Fair Resource Sharing in VPP

VPP (vector packet processor) is a software router and an open source project which is a part of linux foundation project fd.io. As well known from literature, software routers are prone to multiple bottlenecks like bandwidth,cpu. We attempt to share the resources fairly among different flows with a selective packet dropping algorithm.

## Experimental Setup

### Cisco UCS Server
CPU
```
Model name: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
Sockets: 2
Numa nodes: 2
cores per socket: 12
threads per core: 2

```
Network Interfaces
```
2x Intel X520 NICs, dual prort, 10Gbps, full duplex, directly connected with SFP+ cables.
```

Setup
```
DUT: Device under Test (VPP)
TGS: Traffic Generator (DPDK Pktgen)

One line card (2 ports) is connected to VPP and the other line card is connected to pktgen. 
Each port of the two line cards is directly connected to a port of the other line card, as shown below
```
![alt text](https://raw.githubusercontent.com/vamsiDT/fairdrop-results/master/plots/testbed.png)


## Bandwidth Fairdrop

* Bandwidth at the output is a bottleneck when the processing is faster than the wire speed at the output. In this case packets are lost in the tx fifo buffer. 
. Fairdrop algorithm aim is to fairly distribute the available bandwidth resource at the output among all the flows that are processed.

```
In order to emulate the scenario of bandwidth bottleneck, the parameter alpha has been used.
```
* emulated_available_bandwidth = actual_available_bandwidth x alpha
* For example, since our nics have 10Gpbs capacity, alpha=0.1 would mean that emulated available bandwidth at the output is 1Gbps
* Packets are sent to VPP from Pktgen with 20 flows at skewed arrival rates. All the packets are of 64 byte length.
* The algorithm runs at 4% overhead currently.
A comparison between the outputs of fairdrop and taildrop vpp is shown below.

![alt text](https://raw.githubusercontent.com/vamsiDT/fairdrop-results/master/plots/bandwidthexp.png)

## CPU Fairdrop

* Cpu is the bottleneck resource for a software router when the arrival rate of packets is faster than the processing rate. In this case packets are lost in the RX fifo buffer.
* Fairdrop algorithm aim is to calculated the available cpu clock cycles depending on the arrival rate of packets and fairly share the clock cycles among different flows.
* An additional step required for cpu fairdrop is to calculate the cost (cycles/packet required to process) for different flows.
* Packet Generator: 20 flows with equal arrival rates among which 18 flows are ip4 packets and 2 flows are heavy flows. (Heavy flows are flow with high cycles/packet requirement)

```
In order to emulate flows with heavy cost, busyloops are inserted when a heavy flow is processed.
```

A comparison between fairdrop and taildrop showing jain fairness index of cpu cycles and throughput is shown below.

![alt text](https://raw.githubusercontent.com/vamsiDT/fairdrop-results/master/plots/j_index.png)


The effect of fairdrop on the overall throughput and packet loss at the fifo buffer is shown below.
```
Heavy flow cost = 4900 clocks/packet
Light flow cost = 350 clocks/packet
```

Faidrop

![alt text](https://raw.githubusercontent.com/vamsiDT/fairdrop-results/master/plots/sankey_fairdrop.png)

Taildrop

![alt text](https://raw.githubusercontent.com/vamsiDT/fairdrop-results/master/plots/sankey_taildrop.png)
