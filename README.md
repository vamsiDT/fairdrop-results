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

## Bandwidth Fairdrop

Bandwidth is a bottleneck when the processing is faster than the wire speed at the output. In this case packets are lost in the tx fifo buffer.  

---
We generate a skewed traffic with 20 flows using DPDK-Pktgen.

