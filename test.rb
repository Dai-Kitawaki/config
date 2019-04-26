show configuration | display set | no-more 
set version 16.2R2-S1
set groups re0 system host-name MX480-RE0-D147
set groups re1 system host-name MX480-RE1-D147
set apply-groups re0
set apply-groups re1

################################################################ SYSTEM
set system time-zone Asia/Tokyo
set system authentication-order password
set system authentication-order tacplus
set system root-authentication encrypted-password "$1$vnucbP2H$Ddxko4swnyTVViYe7Wg2I1"
set system tacplus-server 10.26.84.32 secret "$9$n4SKCtOvMX7VYMWJDjk5TRhSlvLbsgoaG3687-d2gFn6CBE8LNbwgik01IceKjHqmPT9AuESr"
set system accounting events login
set system accounting events change-log
set system accounting events interactive-commands
set system accounting destination tacplus server 10.26.84.32 secret "$9$i.PQOBEclMB17VbYJZn/CpORev8Xx-jHIcyrW8DiH.z6IRSeK8wYTF39u0bs24oZqm56Ct"
set system login user admin uid 2000
set system login user admin class super-user
set system login user admin authentication encrypted-password "$1$KhfmNkaH$hZDez5MzW92q8KwvNjEKX."
set system services ssh protocol-version v2
set system services ssh connection-limit 4
set system services ssh rate-limit 4
set system syslog user * any emergency
set system syslog host 119.110.90.1 any any
set system syslog host 119.110.90.1 facility-override local5
set system syslog file messages any notice
set system syslog file messages authorization info
set system commit synchronize
set system ntp peer 119.110.88.19
set system ntp peer 119.110.88.251
################################################################# NTP

deactivate system ntp peer 119.110.88.251
set system ntp peer 119.110.88.252
deactivate system ntp peer 119.110.88.252
set system ntp server 119.110.95.249
set system ntp source-address 119.110.88.18
#################################################################

set chassis redundancy graceful-switchover
set chassis aggregated-devices ethernet device-count 32
set chassis alarm management-ethernet link-down ignore


set interfaces xe-0/0/0 gigether-options 802.3ad ae11
set interfaces xe-0/0/1 gigether-options 802.3ad ae11
set interfaces xe-0/0/2 gigether-options 802.3ad ae21
set interfaces xe-0/0/3 gigether-options 802.3ad ae21
set interfaces xe-0/0/4 description toD190-0/0/30
set interfaces xe-0/0/4 gigether-options 802.3ad ae13
set interfaces xe-0/0/5 description toD190-1/0/30
set interfaces xe-0/0/5 gigether-options 802.3ad ae13
set interfaces xe-0/0/6 gigether-options 802.3ad ae14
set interfaces xe-0/0/7 gigether-options 802.3ad ae20
set interfaces xe-0/0/8 description 23K0678-K2D136-MX10003
set interfaces xe-0/0/8 gigether-options 802.3ad ae19
set interfaces xe-0/0/9 gigether-options 802.3ad ae17
set interfaces xe-0/2/0 description 23K0677-K2D135-MX10003
set interfaces xe-0/2/0 gigether-options 802.3ad ae10
set interfaces xe-0/2/1 description 23K0677-K2D135-MX10003
set interfaces xe-0/2/1 gigether-options 802.3ad ae10
set interfaces xe-0/2/2 description 23K0677-K2D135-MX10003
set interfaces xe-0/2/2 gigether-options 802.3ad ae10
set interfaces xe-0/2/3 description 23K0677-K2D135-MX10003
set interfaces xe-0/2/3 gigether-options 802.3ad ae10
set interfaces xe-0/2/4 description 23K0676-K2D134-MX10003
set interfaces xe-0/2/4 gigether-options 802.3ad ae9
set interfaces xe-0/2/5 description 23K0676-K2D134-MX10003
set interfaces xe-0/2/5 gigether-options 802.3ad ae9
set interfaces xe-0/2/6 description 23K0676-K2D134-MX10003
set interfaces xe-0/2/6 gigether-options 802.3ad ae9
set interfaces xe-0/2/7 description 23K0676-K2D134-MX10003
set interfaces xe-0/2/7 gigether-options 802.3ad ae9
set interfaces xe-0/2/8 description 23K0678-K2D136-MX10003
set interfaces xe-0/2/8 gigether-options 802.3ad ae19
set interfaces xe-0/2/9 description 23K0678-K2D136-MX10003
set interfaces xe-0/2/9 gigether-options 802.3ad ae19
set interfaces xe-1/0/0 gigether-options 802.3ad ae12
set interfaces xe-1/0/1 gigether-options 802.3ad ae12
set interfaces xe-1/0/2 gigether-options 802.3ad ae21
set interfaces xe-1/0/3 gigether-options 802.3ad ae21
set interfaces xe-1/0/4 description toD190-0/0/31
set interfaces xe-1/0/4 gigether-options 802.3ad ae13
set interfaces xe-1/0/5 gigether-options 802.3ad ae13
set interfaces xe-1/0/6 description 23K0678-K2D136-MX10003
set interfaces xe-1/0/6 gigether-options 802.3ad ae19
set interfaces xe-1/0/7 gigether-options 802.3ad ae20
set interfaces xe-1/0/8 gigether-options 802.3ad ae16
set interfaces xe-1/0/9 gigether-options 802.3ad ae16
set interfaces xe-1/2/0 description 23K0677-K2D135-MX10003
set interfaces xe-1/2/0 gigether-options 802.3ad ae10
set interfaces xe-1/2/1 description 23K0677-K2D135-MX10003
set interfaces xe-1/2/1 gigether-options 802.3ad ae10
set interfaces xe-1/2/2 description 23K0677-K2D135-MX10003
set interfaces xe-1/2/2 gigether-options 802.3ad ae10
set interfaces xe-1/2/3 description 23K0677-K2D135-MX10003
set interfaces xe-1/2/3 gigether-options 802.3ad ae10
set interfaces xe-1/2/4 description 23K0676-K2D134-MX10003
set interfaces xe-1/2/4 gigether-options 802.3ad ae9
set interfaces xe-1/2/5 description 23K0676-K2D134-MX10003
set interfaces xe-1/2/5 gigether-options 802.3ad ae9
set interfaces xe-1/2/6 description 23K0676-K2D134-MX10003
set interfaces xe-1/2/6 gigether-options 802.3ad ae9
set interfaces xe-1/2/7 description 23K0676-K2D134-MX10003
set interfaces xe-1/2/7 gigether-options 802.3ad ae9
set interfaces xe-1/2/8 description 23K0678-K2D136-MX10003
set interfaces xe-1/2/8 gigether-options 802.3ad ae19
set interfaces xe-1/2/9 description 23K0678-K2D136-MX10003
set interfaces xe-1/2/9 gigether-options 802.3ad ae19
set interfaces xe-2/0/0 gigether-options 802.3ad ae15
set interfaces xe-2/0/1 gigether-options 802.3ad ae15
set interfaces xe-2/0/2 gigether-options 802.3ad ae25
set interfaces xe-2/0/3 description 23K0678-K2D136-MX10003
set interfaces xe-2/0/3 gigether-options 802.3ad ae19
set interfaces xe-2/0/4 description 23K0678-K2D136-MX10003
set interfaces xe-2/0/4 gigether-options 802.3ad ae19
set interfaces xe-2/0/5 gigether-options 802.3ad ae31
set interfaces xe-2/0/6 gigether-options 802.3ad ae31
set interfaces xe-2/0/7 gigether-options 802.3ad ae8
set interfaces xe-2/0/8 gigether-options 802.3ad ae13
set interfaces xe-2/0/9 gigether-options 802.3ad ae17

set interfaces xe-2/2/0 gigether-options 802.3ad ae5
set interfaces xe-2/2/1 gigether-options 802.3ad ae5
set interfaces xe-2/2/2 gigether-options 802.3ad ae5
set interfaces xe-2/2/3 gigether-options 802.3ad ae5

set interfaces xe-2/2/4 gigether-options 802.3ad ae4
set interfaces xe-2/2/5 gigether-options 802.3ad ae4

set interfaces xe-2/2/6 gigether-options 802.3ad ae0
set interfaces xe-2/2/7 gigether-options 802.3ad ae0
set interfaces xe-2/2/8 gigether-options 802.3ad ae0
set interfaces xe-2/2/9 gigether-options 802.3ad ae0

set interfaces et-4/0/0 description 100GbEto143
set interfaces et-4/0/0 disable
set interfaces et-4/0/0 vlan-tagging
set interfaces et-4/0/0 encapsulation flexible-ethernet-services
set interfaces et-4/0/0 unit 100 encapsulation vlan-bridge
set interfaces et-4/0/0 unit 100 vlan-id 100
set interfaces et-4/0/0 unit 500 encapsulation vlan-bridge
set interfaces et-4/0/0 unit 500 vlan-id 500
set interfaces xe-4/2/0 gigether-options 802.3ad ae8
set interfaces xe-4/3/0 description toD145B
set interfaces xe-4/3/0 unit 0 family bridge interface-mode access
set interfaces xe-4/3/0 unit 0 family bridge vlan-id 500

set interfaces ae0 description inter-connect
set interfaces ae0 aggregated-ether-options link-speed 10g
set interfaces ae0 aggregated-ether-options lacp active
set interfaces ae0 unit 0 family inet address 119.110.88.10/30

set interfaces ae1 description toASR9K-D148
set interfaces ae1 aggregated-ether-options link-speed 10g
set interfaces ae1 aggregated-ether-options lacp active
set interfaces ae1 unit 0 family inet address 119.110.88.121/30 ####### Old ASBR
set interfaces ae2 description toASR9K-D149
set interfaces ae2 aggregated-ether-options link-speed 10g
set interfaces ae2 aggregated-ether-options lacp active
set interfaces ae2 unit 0 family inet address 119.110.88.189/30 ####### Old ASBR
set interfaces ae3 description toMLXe-D150
set interfaces ae3 aggregated-ether-options link-speed 10g
set interfaces ae3 aggregated-ether-options lacp active
set interfaces ae3 unit 0 family inet address 119.110.88.129/30 ####### Old ASBR

set interfaces ae4 description toASR9K-D129
set interfaces ae4 aggregated-ether-options link-speed 10g
set interfaces ae4 aggregated-ether-options lacp active
set interfaces ae4 unit 0 family inet address 119.110.88.81/30 ####### Old ASBR

set interfaces ae5 aggregated-ether-options link-speed 10g
set interfaces ae5 aggregated-ether-options lacp active
set interfaces ae5 unit 0 family inet address 119.110.88.149/30

set interfaces ae8 aggregated-ether-options link-speed 10g
set interfaces ae8 aggregated-ether-options lacp active
set interfaces ae8 unit 0 family inet address 119.110.95.22/30

set interfaces ae9 description 23K0676-K2D134-MX10003
set interfaces ae9 aggregated-ether-options link-speed 10g
set interfaces ae9 aggregated-ether-options lacp active
set interfaces ae9 aggregated-ether-options lacp periodic fast
set interfaces ae9 unit 0 family inet address 133.152.13.86/30 ####### NEW ASBR

set interfaces ae10 description 23K0677-K2D135-MX10003
set interfaces ae10 aggregated-ether-options link-speed 10g
set interfaces ae10 aggregated-ether-options lacp active
set interfaces ae10 aggregated-ether-options lacp periodic fast
set interfaces ae10 unit 0 family inet address 133.152.13.102/30 ####### NEW ASBR

set interfaces ae11 aggregated-ether-options link-speed 10g
set interfaces ae11 aggregated-ether-options lacp periodic fast
set interfaces ae11 unit 0 family inet address 119.110.95.61/30 ####### OK
set interfaces ae12 aggregated-ether-options link-speed 10g
set interfaces ae12 aggregated-ether-options lacp active
set interfaces ae12 aggregated-ether-options lacp periodic fast
set interfaces ae12 unit 0 family inet address 119.110.95.69/30 ####### OK
set interfaces ae13 description toD190
set interfaces ae13 aggregated-ether-options link-speed 10g
set interfaces ae13 aggregated-ether-options lacp active
set interfaces ae13 aggregated-ether-options lacp periodic fast
set interfaces ae13 unit 0 family inet address 119.110.95.77/30 ####### OK
set interfaces ae14 aggregated-ether-options link-speed 10g
set interfaces ae14 aggregated-ether-options lacp active
set interfaces ae14 unit 0 family inet address 119.110.95.85/30 ####### OK

set interfaces ae15 aggregated-ether-options link-speed 10g
set interfaces ae15 aggregated-ether-options lacp active
set interfaces ae15 aggregated-ether-options lacp periodic fast
set interfaces ae15 unit 0 family inet address 119.110.95.93/30 ####### OK
set interfaces ae16 aggregated-ether-options link-speed 10g
set interfaces ae16 aggregated-ether-options lacp active
set interfaces ae16 aggregated-ether-options lacp periodic fast
set interfaces ae16 unit 0 family inet address 119.110.95.101/30 ####### OK
set interfaces ae17 aggregated-ether-options link-speed 10g
set interfaces ae17 aggregated-ether-options lacp active
set interfaces ae17 aggregated-ether-options lacp periodic fast
set interfaces ae17 unit 0 family inet address 119.110.88.197/30 ####### OK

set interfaces ae19 description 23K0678-K2D136-MX10003
set interfaces ae19 aggregated-ether-options link-speed 10g
set interfaces ae19 aggregated-ether-options lacp active
set interfaces ae19 aggregated-ether-options lacp periodic fast
set interfaces ae19 unit 0 family inet address 133.152.13.118/30 ####### NEW ASBR

set interfaces ae20 aggregated-ether-options link-speed 10g
set interfaces ae20 aggregated-ether-options lacp active
set interfaces ae20 unit 0 family inet address 119.110.95.109/30 ####### OK
set interfaces ae21 aggregated-ether-options link-speed 10g
set interfaces ae21 aggregated-ether-options lacp active
set interfaces ae21 unit 0 family inet address 119.110.95.165/30 ####### OK
set interfaces ae25 aggregated-ether-options link-speed 10g
set interfaces ae25 aggregated-ether-options lacp active
set interfaces ae25 unit 0 family inet address 119.110.95.237/30 ####### OK

set interfaces ae30 aggregated-ether-options link-speed 10g
set interfaces ae30 aggregated-ether-options lacp active
set interfaces ae30 unit 0

set interfaces ae31 aggregated-ether-options link-speed 10g
set interfaces ae31 aggregated-ether-options lacp active
set interfaces ae31 unit 0 family inet address 119.110.95.153/30 ####### OK

set interfaces irb unit 0 family inet address 119.110.88.90/30
set interfaces lo0 unit 0 family inet filter input protect-RE
set interfaces lo0 unit 0 family inet address 119.110.88.18/32

############################################################################ SNMP
set snmp community SMILERO authorization read-only
set snmp community SMILERO clients 119.110.90.0/27
set snmp community SMILERO clients 119.110.92.250/32
set snmp community SMILERO clients 119.110.95.248/29
set snmp trap-options source-address lo0
set snmp trap-group SMILETRAP version v2
set snmp trap-group SMILETRAP categories chassis
set snmp trap-group SMILETRAP categories link
set snmp trap-group SMILETRAP targets 119.110.95.249
############################################################################

set routing-options nonstop-routing
set routing-options autonomous-system 38634
set routing-options forwarding-table export route-load-balance

set protocols bgp path-selection always-compare-med
set protocols bgp traceoptions file routing_bgp
set protocols bgp traceoptions file size 20k
set protocols bgp traceoptions file files 4
set protocols bgp traceoptions flag damping
set protocols bgp traceoptions flag graceful-restart
set protocols bgp traceoptions flag state
set protocols bgp hold-time 60
set protocols bgp group RR_CLUSTER type internal
set protocols bgp group RR_CLUSTER description CLUSTER-D6
set protocols bgp group RR_CLUSTER local-address 119.110.88.18
set protocols bgp group RR_CLUSTER authentication-key "$9$uOoN1IhXx-Y4Jn/KWLxVb.mfT36tpOcre"
set protocols bgp group RR_CLUSTER peer-as 38634
set protocols bgp group RR_CLUSTER multipath multiple-as
set protocols bgp group RR_CLUSTER neighbor 119.110.88.19
set protocols bgp group RR_CLUSTER neighbor 119.110.88.1
set protocols bgp group RR_CLUSTER neighbor 119.110.88.2
set protocols bgp group iBGP_RR_Clients type internal
set protocols bgp group iBGP_RR_Clients local-address 119.110.88.18
set protocols bgp group iBGP_RR_Clients authentication-key "$9$Q59b3tOKvLbwgoJ36AuIR7-dbgo"
set protocols bgp group iBGP_RR_Clients cluster 119.110.88.255
set protocols bgp group iBGP_RR_Clients peer-as 38634
set protocols bgp group iBGP_RR_Clients multipath multiple-as
set protocols bgp group iBGP_RR_Clients neighbor 119.110.88.20 description ASR9K-D148
set protocols bgp group iBGP_RR_Clients neighbor 119.110.88.21 description ASR9K-D149
set protocols bgp group iBGP_RR_Clients neighbor 119.110.88.17 description MLXe-D150
set protocols bgp group iBGP_RR_Clients neighbor 119.110.88.17 export iBGP-routefilter
set protocols bgp group iBGP_RR_Clients neighbor 119.110.88.16 description ASR9K-D129
set protocols bgp group iBGP_RR_Clients neighbor 119.110.88.15 description MX480-D130
set protocols bgp group RR_neighbor_cluster type internal
set protocols bgp group RR_neighbor_cluster description NEIGHBOR-RR-CLUSTER
set protocols bgp group RR_neighbor_cluster local-address 119.110.88.18
set protocols bgp group RR_neighbor_cluster authentication-key "$9$xUe-w2ZGjHqPn/BRcSKv2goZiq9Ct01EdbjHmPzFB1RheMX7dY4JikpO"
set protocols bgp group RR_neighbor_cluster peer-as 38634
set protocols bgp group RR_neighbor_cluster multipath multiple-as
set protocols bgp group RR_neighbor_cluster neighbor 119.110.88.251 description MX960-142
deactivate protocols bgp group RR_neighbor_cluster neighbor 119.110.88.251
set protocols bgp group RR_neighbor_cluster neighbor 119.110.88.252 description MX960-143_direct
deactivate protocols bgp group RR_neighbor_cluster neighbor 119.110.88.252
set protocols bgp group RR_neighbor_cluster neighbor 119.110.88.31
deactivate protocols bgp group RR_neighbor_cluster neighbor 119.110.88.31
set protocols bgp group eBGP_FlowCollector type external
set protocols bgp group eBGP_FlowCollector description FllowCollector
set protocols bgp group eBGP_FlowCollector local-address 119.110.88.18
set protocols bgp group eBGP_FlowCollector import BGP_Filter_FLOWCOLLECTOR
set protocols bgp group eBGP_FlowCollector authentication-key "$9$MotLx-ZGjfTFev"
set protocols bgp group eBGP_FlowCollector peer-as 65009
set protocols bgp group eBGP_FlowCollector neighbor 119.110.95.251 multihop ttl 4
set protocols bgp group iBGP_New_ASBR type internal
set protocols bgp group iBGP_New_ASBR description Dobn_ASBR
set protocols bgp group iBGP_New_ASBR export Redistribute-OSPF
set protocols bgp group iBGP_New_ASBR export New_ASBR-routefilter
set protocols bgp group iBGP_New_ASBR cluster 119.110.88.255
set protocols bgp group iBGP_New_ASBR peer-as 38634
set protocols bgp group iBGP_New_ASBR multipath multiple-as
set protocols bgp group iBGP_New_ASBR neighbor 133.152.13.117 description to_23K0678-K2D136-MX10003
set protocols bgp group iBGP_New_ASBR neighbor 133.152.13.85 description to_23K0676-K2D134-MX10003
set protocols bgp group iBGP_New_ASBR neighbor 133.152.13.101 description to_23K0677-K2D135-MX10003
set protocols ospf traceoptions file routing_ospf
set protocols ospf traceoptions file size 20k
set protocols ospf traceoptions file files 4
set protocols ospf traceoptions flag state
set protocols ospf traceoptions flag error
set protocols ospf area 0.0.0.0 area-range 119.110.88.0/24
set protocols ospf area 0.0.0.0 interface lo0.0 passive
set protocols ospf area 0.0.0.0 interface lo0.0 metric 1
set protocols ospf area 0.0.0.0 interface ae0.0 interface-type p2p
set protocols ospf area 0.0.0.0 interface irb.0 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae1.0 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae2.0 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae3.0 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae4.0 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae5.0 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae8.0 interface-type p2p
set protocols ospf area 0.6.0.1 stub default-metric 1
set protocols ospf area 0.6.0.1 interface ae11.0 interface-type p2p
set protocols ospf area 0.6.0.2 stub default-metric 1
set protocols ospf area 0.6.0.2 interface ae12.0 interface-type p2p
set protocols ospf area 0.6.0.3 stub default-metric 1
set protocols ospf area 0.6.0.3 interface ae13.0 interface-type p2p
set protocols ospf area 0.6.0.4 stub default-metric 1
set protocols ospf area 0.6.0.4 interface ae14.0 interface-type p2p
set protocols ospf area 0.6.0.7 stub default-metric 1
set protocols ospf area 0.6.0.7 interface ae15.0 interface-type p2p
set protocols ospf area 0.6.0.8 stub default-metric 1
set protocols ospf area 0.6.0.8 interface ae16.0 interface-type p2p
set protocols ospf area 0.6.0.20 stub default-metric 1
set protocols ospf area 0.6.0.20 interface ae20.0 interface-type p2p
set protocols ospf area 0.6.0.20 interface ae20.0 hello-interval 2
set protocols ospf area 0.6.0.21 stub default-metric 1
set protocols ospf area 0.6.0.21 interface ae21.0 interface-type p2p
set protocols ospf area 0.6.0.25 stub default-metric 1
set protocols ospf area 0.6.0.25 interface ae25.0 interface-type p2p
set protocols ospf area 0.6.0.31 stub default-metric 1
set protocols ospf area 0.6.0.31 interface ae31.0 interface-type p2p
set protocols ospf area 0.6.0.9 stub default-metric 1
set protocols ospf area 0.6.0.9 interface ae17.0 interface-type p2p
set protocols ospf area 0.6.0.9 interface ae17.0 hello-interval 2
set protocols lldp interface all
set policy-options prefix-list admin-subnet 119.110.90.0/27
set policy-options prefix-list admin-subnet 119.110.92.250/32
set policy-options prefix-list admin-subnet 119.110.95.248/29
set policy-options prefix-list my-network 119.110.88.0/21
set policy-options prefix-list bgp-configured-peers apply-path "protocols bgp group <*> neighbor <*>"
set policy-options policy-statement BGP_Filter_FLOWCOLLECTOR term deny_all then reject
set policy-options policy-statement New_ASBR-routefilter term local-only from route-filter 119.110.88.0/21 orlonger
set policy-options policy-statement New_ASBR-routefilter term local-only from route-filter 103.115.216.0/22 orlonger
set policy-options policy-statement New_ASBR-routefilter term local-only from route-filter 202.223.8.0/22 orlonger
set policy-options policy-statement New_ASBR-routefilter term local-only from route-filter 133.152.0.0/17 orlonger
set policy-options policy-statement New_ASBR-routefilter term local-only then accept
set policy-options policy-statement New_ASBR-routefilter term drop-other then reject
set policy-options policy-statement Redistribute-OSPF term 1 from protocol ospf
set policy-options policy-statement Redistribute-OSPF term 1 then accept
set policy-options policy-statement Reject then reject
set policy-options policy-statement iBGP-routefilter term local-only from route-filter 119.110.88.0/21 orlonger
set policy-options policy-statement iBGP-routefilter term local-only then accept
set policy-options policy-statement iBGP-routefilter term drop-other then reject
set policy-options policy-statement route-load-balance then load-balance per-packet
set firewall family inet filter protect-RE term allow-management from source-prefix-list admin-subnet
set firewall family inet filter protect-RE term allow-management from protocol tcp
set firewall family inet filter protect-RE term allow-management from destination-port ssh
set firewall family inet filter protect-RE term allow-management then accept
set firewall family inet filter protect-RE term allow-ospf from protocol ospf
set firewall family inet filter protect-RE term allow-ospf then accept
set firewall family inet filter protect-RE term allow-bgp from source-prefix-list bgp-configured-peers
set firewall family inet filter protect-RE term allow-bgp from protocol tcp
set firewall family inet filter protect-RE term allow-bgp from port bgp
set firewall family inet filter protect-RE term allow-bgp then accept
set firewall family inet filter protect-RE term allow-icmp from source-prefix-list admin-subnet
set firewall family inet filter protect-RE term allow-icmp from source-prefix-list bgp-configured-peers
set firewall family inet filter protect-RE term allow-icmp from source-prefix-list my-network
set firewall family inet filter protect-RE term allow-icmp from protocol icmp
set firewall family inet filter protect-RE term allow-icmp from icmp-type echo-request
set firewall family inet filter protect-RE term allow-icmp from icmp-type echo-reply
set firewall family inet filter protect-RE term allow-icmp from icmp-type time-exceeded
set firewall family inet filter protect-RE term allow-icmp from icmp-type unreachable
set firewall family inet filter protect-RE term allow-icmp from icmp-type source-quench
set firewall family inet filter protect-RE term allow-icmp then accept
set firewall family inet filter protect-RE term allow-snmp from source-prefix-list admin-subnet
set firewall family inet filter protect-RE term allow-snmp then accept
set firewall family inet filter protect-RE term allow-traceroute from protocol udp
set firewall family inet filter protect-RE term allow-traceroute from ttl 1
set firewall family inet filter protect-RE term allow-traceroute from destination-port 33434-33523
set firewall family inet filter protect-RE term allow-traceroute then accept
set firewall family inet filter protect-RE term allow-ntp from port ntp
set firewall family inet filter protect-RE term allow-ntp then accept
set firewall family inet filter protect-RE term NewASBR from source-address 133.152.12.0/24
set firewall family inet filter protect-RE term NewASBR from source-address 133.152.13.0/24
set firewall family inet filter protect-RE term NewASBR then accept
set firewall family inet filter protect-RE term discard-everything then discard
set bridge-domains vlan-100 domain-type bridge
set bridge-domains vlan-100 vlan-id 100
set bridge-domains vlan-100 interface et-4/0/0.100
set bridge-domains vlan-100 routing-interface irb.0
set bridge-domains vlan-500 domain-type bridge
set bridge-domains vlan-500 vlan-id 500
set bridge-domains vlan-500 interface et-4/0/0.500
