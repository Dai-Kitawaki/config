<23K0573-K2D134-CE8850>display current-configuration 
!Software Version V200R002C50SPC800
!Last configuration was updated at 2019-04-24 01:09:37+09:00
!Last configuration was saved at 2019-04-24 01:09:43+09:00
#
clock timezone JST add 09:00:00
#
sysname 23K0573-K2D134-CE8850
#
port split dimension interface 100GE1/0/1 to 100GE1/0/6 split-type 4*25GE
port split dimension interface 100GE2/0/1 to 100GE2/0/6 split-type 4*25GE
#
device board 1 board-type CE8850-32CQ-EI
device board 2 board-type CE8850-32CQ-EI
#
drop-profile default
#
dcb pfc
#
dcb ets-profile default
#
ntp server disable
ntp ipv6 server disable
ntp unicast-server 10.25.11.71
ntp unicast-server 10.25.11.71 vpn-instance management source-interface MEth0/0/0
ntp unicast-server 10.25.11.72
ntp unicast-server 10.25.11.72 vpn-instance management source-interface MEth0/0/0
ntp unicast-server 10.25.11.73
ntp unicast-server 10.25.11.73 vpn-instance management source-interface MEth0/0/0
ntp unicast-server 10.25.11.74
ntp unicast-server 10.25.11.74 vpn-instance management source-interface MEth0/0/0
#
telnet server disable
telnet ipv6 server disable
#
diffserv domain default
#
ip vpn-instance management
 ipv4-family
  route-distinguisher 1:100
  vpn-target 1:1 export-extcommunity
  vpn-target 1:1 import-extcommunity
#
aaa
 local-user authentication lock duration 0
 #local-user netadmin password irreversible-cipher $1c$-u0DQ5>Bs5$c='\~%>nwLnaO^9RuFA(h7EH!,#p1$H@m.T-JVe#$
 local-user netadmin service-type ssh
 local-user netadmin level 3
 #
 authentication-scheme default
 #
 authorization-scheme default
 #
 accounting-scheme default
 #
 domain default
 #
 domain default_admin
#
stack
 #
 stack member 1 domain 100
 stack member 1 priority 200
 #
 stack member 2 domain 100
 stack member 2 priority 150
#
interface MEth0/0/0
 ip binding vpn-instance management
 ip address 10.81.0.79 255.255.255.0
#               
interface Eth-Trunk1
 undo portswitch
 description To_22K2041-K2D134-CE12804
 shutdown
 ip address 133.152.13.38 255.255.255.252
 ospf timer hello 2
 ospf enable 1 area 0.0.0.0
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk2
 undo portswitch
 description To_23K0673-K2D135-CE12804
 shutdown
 ip address 133.152.13.46 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.0.0.0
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk3
 undo portswitch
 description To_23K0674-K2D136-CE12804
 shutdown
 ip address 133.152.13.54 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.0.0.0
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk11
 undo portswitch
 description To_EX45V-D165_ae1.0
 shutdown
 ip address 119.110.95.57 255.255.255.252
 ospf enable 1 area 0.6.0.1
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk12
 undo portswitch
 description To_EX45V-D171_ae1.0
 shutdown
 ip address 119.110.95.65 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.2
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk13
 undo portswitch
 description To_EXVC-D190_ae1.0
 shutdown
 ip address 119.110.95.73 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.3
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk14
 undo portswitch
 description To_EX42V-D193_ae1.0
 shutdown
 ip address 119.110.95.81 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.4
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk15
 undo portswitch
 description To_N9KCY-207_Po2
 shutdown
 ip address 119.110.95.89 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.7
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk16
 undo portswitch
 description To_x18K1141-K2D114-VDX6740_Ve2
 shutdown
 ip address 119.110.95.97 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.8
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk17
 undo portswitch
 description To_Nx92160YC-145A_Po10
 shutdown
 ip address 119.110.88.193 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.6.0.9
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk18
 undo portswitch
 description To_NX9KYC-075-DLV_Po11
 shutdown
 ip address 119.110.95.105 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.20
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk19
 undo portswitch
 description To_17K720-K2D089-EX4550_ae1.0
 shutdown
 ip address 119.110.95.161 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.21
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk20
 undo portswitch
 description To_EX45V-D145_ae1.0
 shutdown
 ip address 119.110.95.233 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.25
 mode lacp-dynamic
#
interface Eth-Trunk21
 undo portswitch
 description To_EX45V-TEST
 shutdown
 ip address 119.110.95.169 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.30
 mode lacp-dynamic
 lacp timeout fast
#
interface Eth-Trunk22
 undo portswitch
 description To_EX45V-WKP_ae1.0
 shutdown
 ip address 119.110.95.157 255.255.255.252
 ospf network-type p2p
 ospf enable 1 area 0.6.0.31
 mode lacp-dynamic
#
interface Eth-Trunk101
 undo portswitch
 description To_QFX51VC-B1_ae1.0
 shutdown
 ip address 119.110.95.177 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.6.0.11
 mode lacp-dynamic
#
interface Eth-Trunk102
 undo portswitch
 description To_QFX51VC-B2_ae1.0
 shutdown
 ip address 119.110.95.185 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.6.0.12
 mode lacp-dynamic
#
interface Eth-Trunk103
 undo portswitch
 description To_QFX51VC-B3_ae1.0
 shutdown
 ip address 119.110.95.193 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.6.0.13
 mode lacp-dynamic
#
interface Eth-Trunk104
 undo portswitch
 description To_QFX51VC-B4_ae1.0
 shutdown       
 ip address 119.110.95.201 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.6.0.14
 mode lacp-dynamic
#
interface Eth-Trunk105
 undo portswitch
 description To_QFX51VC-B5_ae1.0
 shutdown
 ip address 119.110.95.209 255.255.255.252
 ospf network-type p2p
 ospf timer hello 2
 ospf enable 1 area 0.6.0.15
 mode lacp-dynamic
#
interface Stack-Port1/1
#
interface Stack-Port2/1
#
interface 10GE1/0/1
#
interface 10GE1/0/2
#
interface 10GE2/0/1
#
interface 10GE2/0/2
#
interface 100GE1/0/1:1
 shutdown
 eth-trunk 11
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/1:2
 shutdown
 eth-trunk 12
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/1:3
 shutdown
 eth-trunk 14
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/1:4
 shutdown
 eth-trunk 22   
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/2:1
 shutdown
 eth-trunk 18
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/2:2
 shutdown
 eth-trunk 15
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/2:3
 shutdown
 eth-trunk 17
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/2:4
 shutdown
 eth-trunk 16
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/3:1
 shutdown
 eth-trunk 19
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/3:2
 shutdown
 eth-trunk 13
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/3:3
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/3:4
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/4:1
 shutdown
 eth-trunk 19
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/4:2
 shutdown
 eth-trunk 13
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/4:3
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/4:4
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/5:1
 shutdown
 eth-trunk 20
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/5:2
 shutdown
 eth-trunk 13
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/5:3
 shutdown
 eth-trunk 21
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/5:4
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/6:1
 shutdown
#
interface 100GE1/0/6:2
 shutdown
#
interface 100GE1/0/6:3
 shutdown
#
interface 100GE1/0/6:4
 shutdown
#
interface 100GE1/0/7
 shutdown
#               
interface 100GE1/0/8
 shutdown
#
interface 100GE1/0/9
 shutdown
 eth-trunk 101
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/10
 shutdown
 eth-trunk 101
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/11
 shutdown
 eth-trunk 102
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/12
 shutdown
 eth-trunk 102
 device transceiver 40GBASE-FIBER
#               
interface 100GE1/0/13
 shutdown
 eth-trunk 103
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/14
 shutdown
 eth-trunk 103
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/15
 shutdown
 eth-trunk 104
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/16
 shutdown
 eth-trunk 104
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/17
 shutdown
 eth-trunk 105  
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/18
 shutdown
 eth-trunk 105
 device transceiver 40GBASE-FIBER
#
interface 100GE1/0/19
 shutdown
#
interface 100GE1/0/20
 shutdown
#
interface 100GE1/0/21
 shutdown
#
interface 100GE1/0/22
 shutdown
#
interface 100GE1/0/23
 shutdown
#
interface 100GE1/0/24
 shutdown
#
interface 100GE1/0/25
 shutdown
#
interface 100GE1/0/26
 shutdown
 eth-trunk 1
 device transceiver 100GBASE-FIBER
#
interface 100GE1/0/27
 shutdown
 eth-trunk 2
 device transceiver 100GBASE-FIBER
#
interface 100GE1/0/28
 shutdown
 eth-trunk 3
 device transceiver 100GBASE-FIBER
#
interface 100GE1/0/29
 port mode stack 
 stack-port 1/1 
 port crc-statistics trigger error-down
#
interface 100GE1/0/30
 port mode stack 
 stack-port 1/1
 port crc-statistics trigger error-down
#
interface 100GE1/0/31
 port mode stack 
 stack-port 1/1
 port crc-statistics trigger error-down
 device transceiver 100GBASE-FIBER
#
interface 100GE1/0/32
 port mode stack 
 stack-port 1/1
 port crc-statistics trigger error-down
 device transceiver 100GBASE-FIBER
#
interface 100GE2/0/1:1
 shutdown
 eth-trunk 11
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/1:2
 shutdown
 eth-trunk 12
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/1:3
 shutdown
 eth-trunk 14
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/1:4
 shutdown
 eth-trunk 22
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/2:1
 shutdown
 eth-trunk 18
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/2:2
 shutdown       
 eth-trunk 15
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/2:3
 shutdown
 eth-trunk 17
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/2:4
 shutdown
 eth-trunk 16
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/3:1
 shutdown
 eth-trunk 19
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/3:2
 shutdown
 eth-trunk 13
 device transceiver 40GBASE-FIBER
#               
interface 100GE2/0/3:3
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/3:4
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/4:1
 shutdown
 eth-trunk 19
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/4:2
 shutdown
 eth-trunk 13
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/4:3
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/4:4
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/5:1
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/5:2
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/5:3
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/5:4
 shutdown
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/6:1
 shutdown
#
interface 100GE2/0/6:2
 shutdown
#
interface 100GE2/0/6:3
 shutdown
#
interface 100GE2/0/6:4
 shutdown
#
interface 100GE2/0/7
 shutdown
#
interface 100GE2/0/8
 shutdown
#
interface 100GE2/0/9
 shutdown
 eth-trunk 101
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/10
 shutdown
 eth-trunk 101
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/11
 shutdown
 eth-trunk 102
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/12
 shutdown
 eth-trunk 102
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/13
 shutdown
 eth-trunk 103
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/14
 shutdown
 eth-trunk 103
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/15
 shutdown       
 eth-trunk 104
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/16
 shutdown
 eth-trunk 104
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/17
 shutdown
 eth-trunk 105
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/18
 shutdown
 eth-trunk 105
 device transceiver 40GBASE-FIBER
#
interface 100GE2/0/19
 shutdown
#
interface 100GE2/0/20
 shutdown       
#
interface 100GE2/0/21
 shutdown
#
interface 100GE2/0/22
 shutdown
#
interface 100GE2/0/23
 shutdown
#
interface 100GE2/0/24
 shutdown
#
interface 100GE2/0/25
 shutdown
#
interface 100GE2/0/26
 shutdown
 eth-trunk 1
 device transceiver 100GBASE-FIBER
#
interface 100GE2/0/27
 shutdown       
 eth-trunk 2
 device transceiver 100GBASE-FIBER
#
interface 100GE2/0/28
 shutdown
 eth-trunk 3
 device transceiver 100GBASE-FIBER
#
interface 100GE2/0/29
 port mode stack 
 stack-port 2/1
 port crc-statistics trigger error-down
#
interface 100GE2/0/30
 port mode stack 
 stack-port 2/1
 port crc-statistics trigger error-down
#
interface 100GE2/0/31
 port mode stack 
 stack-port 2/1
 port crc-statistics trigger error-down
 device transceiver 100GBASE-FIBER
#
interface 100GE2/0/32
 port mode stack 
 stack-port 2/1
 port crc-statistics trigger error-down
 device transceiver 100GBASE-FIBER
#
interface LoopBack0
 ip address 133.152.12.8 255.255.255.255
#
interface NULL0
#
ospf 1
 silent-interface LoopBack0
 area 0.0.0.0
  network 133.152.12.8 0.0.0.0
  network 133.152.13.36 0.0.0.3
  network 133.152.13.44 0.0.0.3
  network 133.152.13.52 0.0.0.3
 area 0.6.0.1
  network 119.110.95.56 0.0.0.3
  stub
 area 0.6.0.2   
  network 119.110.95.64 0.0.0.3
  stub
 area 0.6.0.3
  network 119.110.95.72 0.0.0.3
  stub
 area 0.6.0.4
  network 119.110.95.80 0.0.0.3
  stub
 area 0.6.0.7
  network 119.110.95.88 0.0.0.3
  stub
 area 0.6.0.8
  network 119.110.95.96 0.0.0.3
  stub
 area 0.6.0.9
  network 119.110.88.192 0.0.0.3
  stub
 area 0.6.0.11
  network 119.110.95.176 0.0.0.3
  stub
 area 0.6.0.12
  network 119.110.95.184 0.0.0.3
  stub          
 area 0.6.0.13
  network 119.110.95.192 0.0.0.3
  stub
 area 0.6.0.14
  network 119.110.95.200 0.0.0.3
  stub
 area 0.6.0.15
  network 119.110.95.208 0.0.0.3
  stub
 area 0.6.0.20
  network 119.110.95.104 0.0.0.3
  stub
 area 0.6.0.21
  network 119.110.95.160 0.0.0.3
  stub
 area 0.6.0.25
  network 119.110.95.232 0.0.0.3
  stub
 area 0.6.0.30
  network 119.110.95.168 0.0.0.3
  stub
 area 0.6.0.31
  network 119.110.95.156 0.0.0.3
  stub
#
ip route-static vpn-instance management 0.0.0.0 0.0.0.0 10.81.0.254
#
snmp-agent
snmp-agent local-engineid 800007DB03AC751D42F1F1
#
snmp-agent sys-info version v3
snmp-agent group v3 network-group privacy
#
snmp-agent usm-user v3 network-snmp-user
snmp-agent usm-user v3 network-snmp-user group network-group
 # agent usm-user v3 network-snmp-user authentication-mode sha cipher %^%#W";i(4<R.(t{Qp='6jt'7!#L;1+Nu)#~3`IS1:*0%^%#
 # snmp-agent usm-user v3 network-snmp-user privacy-mode aes128 cipher %^%#GkyLF$YN441:1TIJj4eLH95qGHIOj1ExNQCvV<m9%^%#
#
snmp-agent trap source MEth0/0/0
#
lldp enable
#
stelnet ipv4 server enable
stelnet ipv6 server enable
ssh user netadmin
ssh user netadmin authentication-type password
ssh user netadmin service-type stelnet
ssh authorization-type default aaa
#
ssh server cipher aes256_ctr aes128_ctr
ssh server hmac sha2_256_96 sha2_256 sha1_96
ssh server key-exchange dh_group_exchange_sha256 dh_group_exchange_sha1 ecdh_sha2_nistp256 ecdh_sha2_nistp384 ecdh_sha2_nistp521 sm2_kep
#
user-interface con 0
 authentication-mode password
 set authentication password cipher $1c$_o1{B4<$eJ$X+4vW};J9II=Q3Bp2>'4>P`CXW(tIJP:g88|S0i9$
 idle-timeout 60 0
#
user-interface vty 0 4
 authentication-mode aaa
 user privilege level 3
 idle-timeout 60 0
 protocol inbound ssh
#
vm-manager
#
return
