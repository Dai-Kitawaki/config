## 🛠️【作業】NET-3133_back-production GW切替

### 概要
●Spine (DC1) のGWアドレスを Spine (DC6) へ移設  

1. 【事前作業】 DC6 NicoSphere に GW切替用の設定を投入  
※IFはUPさせないので注意

1. 【メンテ当日】DC1 SpineのGW設定を消す（回線断）  
※HSRPの不要な切り替わりを防ぐ為 2号機から作業  

1. 【メンテ当日】DC6 SpineのIFを有効にする


●[移行対象GWはこちらのスプシ参照](https://docs.google.com/spreadsheets/d/1LgBvj4jF2TfUQs83C-Mwqk5li0YbN5ZpntfgOybc03g/edit#gid=1296365040)  

------------------------
### 1. DC6 NicoSphereにGWの設定を入れる ( IFは Down にしておく!)
### [22K2039-K2D022-CE8850 / 10.81.0.13 ](https://docs.google.com/spreadsheets/d/1b3y44zG8fqMLKzecoCpmpUxvp5d1A0eVsMhXfsREq8A/edit#gid=1167760439&range=D21)  
#### 事前確認
```rb
# Diff #
dis conf cha

# Log # 
dis logbuffer

# CPU #
dis cpu

# OSPF database （AdvRouter is 10.0.0.10）#
display ospf lsdb　# 比較用に全てのDB情報取得

# Vlan が有効になっていること #
dis vlan 3101 to 3710

# SVI status #
# 作業前なので対象VLANの表示無し
dis int brief Vlanif | include 3
```
---
#### 設定変更 ( IFは Down にしておく! )
```rb
sys
#
interface Vlanif3101
 shutdown
 ip address 10.26.1.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
quit
dis con cha
commit
#
quit
# OSPF database #
display ospf lsdb
"事前に取得したDBと比較（変化がないこと）"

# SVI status （作成したSVIがUPしていないこと）#
dis int brief | in 3101

# 疎通確認 (DC1 のGWより応答ある想定)
ping -c 2 10.26.1.254

# ARP #
display arp | in 10.26.1.254
--------------------------------------------------------
#
# 問題なければ残りのVlanにも設定を投入
#
sys
#
interface Vlanif3102
 shutdown
 ip address 10.26.2.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3103
 shutdown
 ip address 10.26.3.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3104
 shutdown
 ip address 10.26.4.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3105
 shutdown
 ip address 10.26.5.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3106
 shutdown
 ip address 10.26.6.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3107
 shutdown
 ip address 10.26.7.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3108
 shutdown
 ip address 10.26.8.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3110
 shutdown
 ip address 10.26.10.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3111
 shutdown
 ip address 10.26.11.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3112
 shutdown
 ip address 10.26.12.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3113
 shutdown
 ip address 10.26.13.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3114
 shutdown
 ip address 10.26.14.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3115
 shutdown
 ip address 10.26.15.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3116
 shutdown
 ip address 10.26.16.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3117
 shutdown
 ip address 10.26.17.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3118
 shutdown
 ip address 10.26.18.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3119
 shutdown
 ip address 10.26.19.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3120
 shutdown
 ip address 10.26.20.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3121
 shutdown
 ip address 10.26.21.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3122
 shutdown
 ip address 10.26.22.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3123
 shutdown
 ip address 10.26.23.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3124
 shutdown
 ip address 10.26.24.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3125
 shutdown
 ip address 10.26.25.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3201
 shutdown
 ip address 10.26.26.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3202
 shutdown
 ip address 10.26.27.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3203
 shutdown
 ip address 10.26.28.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3204
 shutdown
 ip address 10.26.29.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3205
 shutdown
 ip address 10.26.30.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3206
 shutdown
 ip address 10.26.31.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3207
 shutdown
 ip address 10.26.39.254/21 255.255.248.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3208
 shutdown
 ip address 10.26.40.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3209
 shutdown
 ip address 10.26.41.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3210
 shutdown
 ip address 10.26.42.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#

interface Vlanif3242
 shutdown
 ip address 10.26.44.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3244
 shutdown
 ip address 10.26.46.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3245
 shutdown
 ip address 10.26.47.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3246
 shutdown
 ip address 10.26.48.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3247
 shutdown
 ip address 10.26.49.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3248
 shutdown
 ip address 10.26.50.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3249
 shutdown
 ip address 10.26.51.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3250
 shutdown
 ip address 10.26.52.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3281
 shutdown
 ip address 10.26.53.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3282
 shutdown
 ip address 10.26.54.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3283
 shutdown
 ip address 10.26.55.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3285
 shutdown
 ip address 10.26.57.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3501
 shutdown
 ip address 10.26.58.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3502
 shutdown
 ip address 10.26.59.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3503
 shutdown
 ip address 10.26.60.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3504
 shutdown
 ip address 10.26.61.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3505
 shutdown
 ip address 10.26.62.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3506
 shutdown
 ip address 10.26.63.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3507
 shutdown
 ip address 10.26.64.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3508
 shutdown
 ip address 10.26.65.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3509
 shutdown
 ip address 10.26.66.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3510
 shutdown
 ip address 10.26.67.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3541
 shutdown
 ip address 10.26.68.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3542
 shutdown
 ip address 10.26.69.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3543
 shutdown
 ip address 10.26.70.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3544
 shutdown
 ip address 10.26.71.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3545
 shutdown
 ip address 10.26.72.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3546
 shutdown
 ip address 10.26.73.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3547
 shutdown
 ip address 10.26.74.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3548
 shutdown
 ip address 10.26.75.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3549
 shutdown
 ip address 10.26.76.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3550
 shutdown
 ip address 10.26.77.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3551
 shutdown
 ip address 10.26.78.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3552
 shutdown
 ip address 10.26.79.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3553
 shutdown
 ip address 10.26.80.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3554
 shutdown
 ip address 10.26.81.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3555
 shutdown
 ip address 10.26.82.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3556
 shutdown
 ip address 10.26.83.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3557
 shutdown
 ip address 10.26.84.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3558
 shutdown
 ip address 10.26.85.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3559
 shutdown
 ip address 10.26.86.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3560
 shutdown
 ip address 10.26.87.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3621
 shutdown
 ip address 10.26.88.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3622
 shutdown
 ip address 10.26.89.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3623
 shutdown
 ip address 10.26.90.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3624
 shutdown
 ip address 10.26.91.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3625
 shutdown
 ip address 10.26.92.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3626
 shutdown
 ip address 10.26.93.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3628
 shutdown
 ip address 10.26.95.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3629
 shutdown
 ip address 10.26.96.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3630
 shutdown
 ip address 10.26.97.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3661
 shutdown
 ip address 10.26.98.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3663
 shutdown
 ip address 10.26.100.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3664
 shutdown
 ip address 10.26.101.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3665
 shutdown
 ip address 10.26.102.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3666
 shutdown
 ip address 10.26.103.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3667
 shutdown
 ip address 10.26.104.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3668
 shutdown
 ip address 10.26.105.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3669
 shutdown
 ip address 10.26.106.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3670
 shutdown
 ip address 10.26.107.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3701
 shutdown
 ip address 10.26.108.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3702
 shutdown
 ip address 10.26.109.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3703
 shutdown
 ip address 10.26.110.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3704
 shutdown
 ip address 10.26.111.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3705
 shutdown
 ip address 10.26.112.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3706
 shutdown
 ip address 10.26.113.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3707
 shutdown
 ip address 10.26.114.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3708
 shutdown
 ip address 10.26.115.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3709
 shutdown
 ip address 10.26.116.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
interface Vlanif3710
 shutdown
 ip address 10.26.117.254/24 255.255.255.0
 ospf enable 2 area 0.2.0.3
#
ospf 2
 silent-interface Vlanif3101
 silent-interface Vlanif3102
 silent-interface Vlanif3103
 silent-interface Vlanif3104
 silent-interface Vlanif3105
 silent-interface Vlanif3106
 silent-interface Vlanif3107
 silent-interface Vlanif3108
 silent-interface Vlanif3110
 silent-interface Vlanif3111
 silent-interface Vlanif3112
 silent-interface Vlanif3113
 silent-interface Vlanif3114
 silent-interface Vlanif3115
 silent-interface Vlanif3116
 silent-interface Vlanif3118
 silent-interface Vlanif3119
 silent-interface Vlanif3120
 silent-interface Vlanif3121
 silent-interface Vlanif3122
 silent-interface Vlanif3123
 silent-interface Vlanif3124
 silent-interface Vlanif3125
 silent-interface Vlanif3117
 silent-interface Vlanif3202
 silent-interface Vlanif3203
 silent-interface Vlanif3204
 silent-interface Vlanif3205
 silent-interface Vlanif3206
 silent-interface Vlanif3207
 silent-interface Vlanif3208
 silent-interface Vlanif3209
 silent-interface Vlanif3210
 silent-interface Vlanif3201
 silent-interface Vlanif3242
 silent-interface Vlanif3244
 silent-interface Vlanif3245
 silent-interface Vlanif3246
 silent-interface Vlanif3247
 silent-interface Vlanif3248
 silent-interface Vlanif3249
 silent-interface Vlanif3250
 silent-interface Vlanif3281
 silent-interface Vlanif3282
 silent-interface Vlanif3283
 silent-interface Vlanif3285
 silent-interface Vlanif3501
 silent-interface Vlanif3502
 silent-interface Vlanif3503
 silent-interface Vlanif3504
 silent-interface Vlanif3505
 silent-interface Vlanif3506
 silent-interface Vlanif3507
 silent-interface Vlanif3508
 silent-interface Vlanif3509
 silent-interface Vlanif3510
 silent-interface Vlanif3541
 silent-interface Vlanif3542
 silent-interface Vlanif3543
 silent-interface Vlanif3544
 silent-interface Vlanif3545
 silent-interface Vlanif3546
 silent-interface Vlanif3547
 silent-interface Vlanif3548
 silent-interface Vlanif3549
 silent-interface Vlanif3550
 silent-interface Vlanif3551
 silent-interface Vlanif3552
 silent-interface Vlanif3553
 silent-interface Vlanif3554
 silent-interface Vlanif3555
 silent-interface Vlanif3556
 silent-interface Vlanif3557
 silent-interface Vlanif3558
 silent-interface Vlanif3559
 silent-interface Vlanif3560
 silent-interface Vlanif3621
 silent-interface Vlanif3622
 silent-interface Vlanif3623
 silent-interface Vlanif3624
 silent-interface Vlanif3625
 silent-interface Vlanif3626
 silent-interface Vlanif3628
 silent-interface Vlanif3629
 silent-interface Vlanif3630
 silent-interface Vlanif3661
 silent-interface Vlanif3663
 silent-interface Vlanif3664
 silent-interface Vlanif3665
 silent-interface Vlanif3666
 silent-interface Vlanif3667
 silent-interface Vlanif3668
 silent-interface Vlanif3669
 silent-interface Vlanif3670
 silent-interface Vlanif3701
 silent-interface Vlanif3702
 silent-interface Vlanif3703
 silent-interface Vlanif3704
 silent-interface Vlanif3705
 silent-interface Vlanif3706
 silent-interface Vlanif3707
 silent-interface Vlanif3708
 silent-interface Vlanif3709
 silent-interface Vlanif3710
quit
#
#
qos group ACL_group
 group-member interface Vlanif3101
 group-member interface Vlanif3102
 group-member interface Vlanif3103
 group-member interface Vlanif3104
 group-member interface Vlanif3105
 group-member interface Vlanif3106
 group-member interface Vlanif3107
 group-member interface Vlanif3108
 group-member interface Vlanif3110
 group-member interface Vlanif3111
 group-member interface Vlanif3112
 group-member interface Vlanif3113
 group-member interface Vlanif3114
 group-member interface Vlanif3115
 group-member interface Vlanif3116
 group-member interface Vlanif3118
 group-member interface Vlanif3119
 group-member interface Vlanif3120
 group-member interface Vlanif3121
 group-member interface Vlanif3122
 group-member interface Vlanif3123
 group-member interface Vlanif3124
 group-member interface Vlanif3125
 group-member interface Vlanif3117
 group-member interface Vlanif3202
 group-member interface Vlanif3203
 group-member interface Vlanif3204
 group-member interface Vlanif3205
 group-member interface Vlanif3206
 group-member interface Vlanif3207
 group-member interface Vlanif3208
 group-member interface Vlanif3209
 group-member interface Vlanif3210
 group-member interface Vlanif3201
 group-member interface Vlanif3242
 group-member interface Vlanif3244
 group-member interface Vlanif3245
 group-member interface Vlanif3246
 group-member interface Vlanif3247
 group-member interface Vlanif3248
 group-member interface Vlanif3249
 group-member interface Vlanif3250
 group-member interface Vlanif3281
 group-member interface Vlanif3282
 group-member interface Vlanif3283
 group-member interface Vlanif3285
 group-member interface Vlanif3501
 group-member interface Vlanif3502
 group-member interface Vlanif3503
 group-member interface Vlanif3504
 group-member interface Vlanif3505
 group-member interface Vlanif3506
 group-member interface Vlanif3507
 group-member interface Vlanif3508
 group-member interface Vlanif3509
 group-member interface Vlanif3510
 group-member interface Vlanif3541
 group-member interface Vlanif3542
 group-member interface Vlanif3543
 group-member interface Vlanif3544
 group-member interface Vlanif3545
 group-member interface Vlanif3546
 group-member interface Vlanif3547
 group-member interface Vlanif3548
 group-member interface Vlanif3549
 group-member interface Vlanif3550
 group-member interface Vlanif3551
 group-member interface Vlanif3552
 group-member interface Vlanif3553
 group-member interface Vlanif3554
 group-member interface Vlanif3555
 group-member interface Vlanif3556
 group-member interface Vlanif3557
 group-member interface Vlanif3558
 group-member interface Vlanif3559
 group-member interface Vlanif3560
 group-member interface Vlanif3621
 group-member interface Vlanif3622
 group-member interface Vlanif3623
 group-member interface Vlanif3624
 group-member interface Vlanif3625
 group-member interface Vlanif3626
 group-member interface Vlanif3628
 group-member interface Vlanif3629
 group-member interface Vlanif3630
 group-member interface Vlanif3661
 group-member interface Vlanif3663
 group-member interface Vlanif3664
 group-member interface Vlanif3665
 group-member interface Vlanif3666
 group-member interface Vlanif3667
 group-member interface Vlanif3668
 group-member interface Vlanif3669
 group-member interface Vlanif3670
 group-member interface Vlanif3701
 group-member interface Vlanif3702
 group-member interface Vlanif3703
 group-member interface Vlanif3704
 group-member interface Vlanif3705
 group-member interface Vlanif3706
 group-member interface Vlanif3707
 group-member interface Vlanif3708
 group-member interface Vlanif3709
 group-member interface Vlanif3710
# 
 traffic-filter acl isolate_prod_dev inbound
quit
#

 # 適用したコンフィグの確認 #
dis con candidate

# Commit #
commit
quit

# Diff #
dis conf cha

# Save #
save 
```      
#### 作業後 確認
```rb
# CPU #
dis cpu

# OSPF database #
display ospf lsdb
"事前に取得したDBと比較（変化がないこと）"

# SVI status （作成したSVIがUPしていないこと）#
dis int brief | in 3

# 疎通確認 
ping -c 2 10.26.1.254
ping -c 2 10.26.2.254
ping -c 2 10.26.3.254
ping -c 2 10.26.4.254
ping -c 2 10.26.5.254
ping -c 2 10.26.6.254
ping -c 2 10.26.7.254
ping -c 2 10.26.8.254
ping -c 2 10.26.10.254
ping -c 2 10.26.11.254
ping -c 2 10.26.12.254
ping -c 2 10.26.13.254
ping -c 2 10.26.14.254
ping -c 2 10.26.15.254
ping -c 2 10.26.16.254
ping -c 2 10.26.18.254
ping -c 2 10.26.19.254
ping -c 2 10.26.20.254
ping -c 2 10.26.21.254
ping -c 2 10.26.22.254
ping -c 2 10.26.23.254
ping -c 2 10.26.24.254
ping -c 2 10.26.25.254
ping -c 2 10.26.17.254
ping -c 2 10.26.27.254
ping -c 2 10.26.28.254
ping -c 2 10.26.29.254
ping -c 2 10.26.30.254
ping -c 2 10.26.31.254
ping -c 2 10.26.39.254
ping -c 2 10.26.40.254
ping -c 2 10.26.41.254
ping -c 2 10.26.42.254
ping -c 2 10.26.26.254
ping -c 2 10.26.44.254
ping -c 2 10.26.46.254
ping -c 2 10.26.47.254
ping -c 2 10.26.48.254
ping -c 2 10.26.49.254
ping -c 2 10.26.50.254
ping -c 2 10.26.51.254
ping -c 2 10.26.52.254
ping -c 2 10.26.53.254
ping -c 2 10.26.54.254
ping -c 2 10.26.55.254
ping -c 2 10.26.57.254
ping -c 2 10.26.58.254
ping -c 2 10.26.59.254
ping -c 2 10.26.60.254
ping -c 2 10.26.61.254
ping -c 2 10.26.62.254
ping -c 2 10.26.63.254
ping -c 2 10.26.64.254
ping -c 2 10.26.65.254
ping -c 2 10.26.66.254
ping -c 2 10.26.67.254
ping -c 2 10.26.68.254
ping -c 2 10.26.69.254
ping -c 2 10.26.70.254
ping -c 2 10.26.71.254
ping -c 2 10.26.72.254
ping -c 2 10.26.73.254
ping -c 2 10.26.74.254
ping -c 2 10.26.75.254
ping -c 2 10.26.76.254
ping -c 2 10.26.77.254
ping -c 2 10.26.78.254
ping -c 2 10.26.79.254
ping -c 2 10.26.80.254
ping -c 2 10.26.81.254
ping -c 2 10.26.82.254
ping -c 2 10.26.83.254
ping -c 2 10.26.84.254
ping -c 2 10.26.85.254
ping -c 2 10.26.86.254
ping -c 2 10.26.87.254
ping -c 2 10.26.88.254
ping -c 2 10.26.89.254
ping -c 2 10.26.90.254
ping -c 2 10.26.91.254
ping -c 2 10.26.92.254
ping -c 2 10.26.93.254
ping -c 2 10.26.95.254
ping -c 2 10.26.96.254
ping -c 2 10.26.97.254
ping -c 2 10.26.98.254
ping -c 2 10.26.100.254
ping -c 2 10.26.101.254
ping -c 2 10.26.102.254
ping -c 2 10.26.103.254
ping -c 2 10.26.104.254
ping -c 2 10.26.105.254
ping -c 2 10.26.106.254
ping -c 2 10.26.107.254
ping -c 2 10.26.108.254
ping -c 2 10.26.109.254
ping -c 2 10.26.110.254
ping -c 2 10.26.111.254
ping -c 2 10.26.112.254
ping -c 2 10.26.113.254
ping -c 2 10.26.114.254
ping -c 2 10.26.115.254
ping -c 2 10.26.116.254
ping -c 2 10.26.117.254

# ARP #
display arp | in 10.26.1.254
display arp | in 10.26.2.254
display arp | in 10.26.3.254
display arp | in 10.26.4.254
display arp | in 10.26.5.254
display arp | in 10.26.6.254
display arp | in 10.26.7.254
display arp | in 10.26.8.254
display arp | in 10.26.10.254
display arp | in 10.26.11.254
display arp | in 10.26.12.254
display arp | in 10.26.13.254
display arp | in 10.26.14.254
display arp | in 10.26.15.254
display arp | in 10.26.16.254
display arp | in 10.26.18.254
display arp | in 10.26.19.254
display arp | in 10.26.20.254
display arp | in 10.26.21.254
display arp | in 10.26.22.254
display arp | in 10.26.23.254
display arp | in 10.26.24.254
display arp | in 10.26.25.254
display arp | in 10.26.17.254
display arp | in 10.26.27.254
display arp | in 10.26.28.254
display arp | in 10.26.29.254
display arp | in 10.26.30.254
display arp | in 10.26.31.254
display arp | in 10.26.39.254
display arp | in 10.26.40.254
display arp | in 10.26.41.254
display arp | in 10.26.42.254
display arp | in 10.26.26.254
display arp | in 10.26.44.254
display arp | in 10.26.46.254
display arp | in 10.26.47.254
display arp | in 10.26.48.254
display arp | in 10.26.49.254
display arp | in 10.26.50.254
display arp | in 10.26.51.254
display arp | in 10.26.52.254
display arp | in 10.26.53.254
display arp | in 10.26.54.254
display arp | in 10.26.55.254
display arp | in 10.26.57.254
display arp | in 10.26.58.254
display arp | in 10.26.59.254
display arp | in 10.26.60.254
display arp | in 10.26.61.254
display arp | in 10.26.62.254
display arp | in 10.26.63.254
display arp | in 10.26.64.254
display arp | in 10.26.65.254
display arp | in 10.26.66.254
display arp | in 10.26.67.254
display arp | in 10.26.68.254
display arp | in 10.26.69.254
display arp | in 10.26.70.254
display arp | in 10.26.71.254
display arp | in 10.26.72.254
display arp | in 10.26.73.254
display arp | in 10.26.74.254
display arp | in 10.26.75.254
display arp | in 10.26.76.254
display arp | in 10.26.77.254
display arp | in 10.26.78.254
display arp | in 10.26.79.254
display arp | in 10.26.80.254
display arp | in 10.26.81.254
display arp | in 10.26.82.254
display arp | in 10.26.83.254
display arp | in 10.26.84.254
display arp | in 10.26.85.254
display arp | in 10.26.86.254
display arp | in 10.26.87.254
display arp | in 10.26.88.254
display arp | in 10.26.89.254
display arp | in 10.26.90.254
display arp | in 10.26.91.254
display arp | in 10.26.92.254
display arp | in 10.26.93.254
display arp | in 10.26.95.254
display arp | in 10.26.96.254
display arp | in 10.26.97.254
display arp | in 10.26.98.254
display arp | in 10.26.100.254
display arp | in 10.26.101.254
display arp | in 10.26.102.254
display arp | in 10.26.103.254
display arp | in 10.26.104.254
display arp | in 10.26.105.254
display arp | in 10.26.106.254
display arp | in 10.26.107.254
display arp | in 10.26.108.254
display arp | in 10.26.109.254
display arp | in 10.26.110.254
display arp | in 10.26.111.254
display arp | in 10.26.112.254
display arp | in 10.26.113.254
display arp | in 10.26.114.254
display arp | in 10.26.115.254
display arp | in 10.26.116.254
display arp | in 10.26.117.254
"cisco のMAC(0081.c4f7.227f or 0000.0c9f.fe4e）が正しい"
```
---
#### 👼👼👼ロールバック👼👼👼
```rb
# Diff #
display configuration rollback result

# Rollback #
rollback configuration last 1
```      
------------------------

### 2-1 【メンテ当日】DC1 SpineのGWの設定を消す（回線断） 
### [21K1033-3FJ17-NX9272-02 / 10.102.5.2 ](https://docs.google.com/spreadsheets/d/1TvojSd9qo_HbC_H88KLRNzfZqlq6YCt90lfRstQcqvk/edit#gid=1167760439&range=I625)  
#### 事前確認
```rb
# Diff #
sho run diff

# Checkpoint # 
sho checkpoint summary
適宜 >> #clear checkpoint database user
checkpoint stable
sho diff rollback-patch checkpoint stable running-config

# CPU #
sho processes cpu | ex 0.0

# LOG #
sho logging last 50

# ARP GW MACアドレスがCiscoであること #
sho ip arp | in 10.26.1.254
sho ip arp | in 10.26.2.254
sho ip arp | in 10.26.3.254
sho ip arp | in 10.26.4.254
sho ip arp | in 10.26.5.254
sho ip arp | in 10.26.6.254
sho ip arp | in 10.26.7.254
sho ip arp | in 10.26.8.254
sho ip arp | in 10.26.10.254
sho ip arp | in 10.26.11.254
sho ip arp | in 10.26.12.254
sho ip arp | in 10.26.13.254
sho ip arp | in 10.26.14.254
sho ip arp | in 10.26.15.254
sho ip arp | in 10.26.16.254
sho ip arp | in 10.26.18.254
sho ip arp | in 10.26.19.254
sho ip arp | in 10.26.20.254
sho ip arp | in 10.26.21.254
sho ip arp | in 10.26.22.254
sho ip arp | in 10.26.23.254
sho ip arp | in 10.26.24.254
sho ip arp | in 10.26.25.254
sho ip arp | in 10.26.17.254
sho ip arp | in 10.26.27.254
sho ip arp | in 10.26.28.254
sho ip arp | in 10.26.29.254
sho ip arp | in 10.26.30.254
sho ip arp | in 10.26.31.254
sho ip arp | in 10.26.39.254
sho ip arp | in 10.26.40.254
sho ip arp | in 10.26.41.254
sho ip arp | in 10.26.42.254
sho ip arp | in 10.26.26.254
sho ip arp | in 10.26.44.254
sho ip arp | in 10.26.46.254
sho ip arp | in 10.26.47.254
sho ip arp | in 10.26.48.254
sho ip arp | in 10.26.49.254
sho ip arp | in 10.26.50.254
sho ip arp | in 10.26.51.254
sho ip arp | in 10.26.52.254
sho ip arp | in 10.26.53.254
sho ip arp | in 10.26.54.254
sho ip arp | in 10.26.55.254
sho ip arp | in 10.26.57.254
sho ip arp | in 10.26.58.254
sho ip arp | in 10.26.59.254
sho ip arp | in 10.26.60.254
sho ip arp | in 10.26.61.254
sho ip arp | in 10.26.62.254
sho ip arp | in 10.26.63.254
sho ip arp | in 10.26.64.254
sho ip arp | in 10.26.65.254
sho ip arp | in 10.26.66.254
sho ip arp | in 10.26.67.254
sho ip arp | in 10.26.68.254
sho ip arp | in 10.26.69.254
sho ip arp | in 10.26.70.254
sho ip arp | in 10.26.71.254
sho ip arp | in 10.26.72.254
sho ip arp | in 10.26.73.254
sho ip arp | in 10.26.74.254
sho ip arp | in 10.26.75.254
sho ip arp | in 10.26.76.254
sho ip arp | in 10.26.77.254
sho ip arp | in 10.26.78.254
sho ip arp | in 10.26.79.254
sho ip arp | in 10.26.80.254
sho ip arp | in 10.26.81.254
sho ip arp | in 10.26.82.254
sho ip arp | in 10.26.83.254
sho ip arp | in 10.26.84.254
sho ip arp | in 10.26.85.254
sho ip arp | in 10.26.86.254
sho ip arp | in 10.26.87.254
sho ip arp | in 10.26.88.254
sho ip arp | in 10.26.89.254
sho ip arp | in 10.26.90.254
sho ip arp | in 10.26.91.254
sho ip arp | in 10.26.92.254
sho ip arp | in 10.26.93.254
sho ip arp | in 10.26.95.254
sho ip arp | in 10.26.96.254
sho ip arp | in 10.26.97.254
sho ip arp | in 10.26.98.254
sho ip arp | in 10.26.100.254
sho ip arp | in 10.26.101.254
sho ip arp | in 10.26.102.254
sho ip arp | in 10.26.103.254
sho ip arp | in 10.26.104.254
sho ip arp | in 10.26.105.254
sho ip arp | in 10.26.106.254
sho ip arp | in 10.26.107.254
sho ip arp | in 10.26.108.254
sho ip arp | in 10.26.109.254
sho ip arp | in 10.26.110.254
sho ip arp | in 10.26.111.254
sho ip arp | in 10.26.112.254
sho ip arp | in 10.26.113.254
sho ip arp | in 10.26.114.254
sho ip arp | in 10.26.115.254
sho ip arp | in 10.26.116.254
sho ip arp | in 10.26.117.254

# HSRP #
sho hsrp group 3101 brief
sho hsrp group 3102 brief
sho hsrp group 3103 brief
sho hsrp group 3104 brief
sho hsrp group 3105 brief
sho hsrp group 3106 brief
sho hsrp group 3107 brief
sho hsrp group 3108 brief
sho hsrp group 3110 brief
sho hsrp group 3111 brief
sho hsrp group 3112 brief
sho hsrp group 3113 brief
sho hsrp group 3114 brief
sho hsrp group 3115 brief
sho hsrp group 3116 brief
sho hsrp group 3118 brief
sho hsrp group 3119 brief
sho hsrp group 3120 brief
sho hsrp group 3121 brief
sho hsrp group 3122 brief
sho hsrp group 3123 brief
sho hsrp group 3124 brief
sho hsrp group 3125 brief
sho hsrp group 3117 brief
sho hsrp group 3202 brief
sho hsrp group 3203 brief
sho hsrp group 3204 brief
sho hsrp group 3205 brief
sho hsrp group 3206 brief
sho hsrp group 3207 brief
sho hsrp group 3208 brief
sho hsrp group 3209 brief
sho hsrp group 3210 brief
sho hsrp group 3201 brief
sho hsrp group 3242 brief
sho hsrp group 3244 brief
sho hsrp group 3245 brief
sho hsrp group 3246 brief
sho hsrp group 3247 brief
sho hsrp group 3248 brief
sho hsrp group 3249 brief
sho hsrp group 3250 brief
sho hsrp group 3281 brief
sho hsrp group 3282 brief
sho hsrp group 3283 brief
sho hsrp group 3285 brief
sho hsrp group 3501 brief
sho hsrp group 3502 brief
sho hsrp group 3503 brief
sho hsrp group 3504 brief
sho hsrp group 3505 brief
sho hsrp group 3506 brief
sho hsrp group 3507 brief
sho hsrp group 3508 brief
sho hsrp group 3509 brief
sho hsrp group 3510 brief
sho hsrp group 3541 brief
sho hsrp group 3542 brief
sho hsrp group 3543 brief
sho hsrp group 3544 brief
sho hsrp group 3545 brief
sho hsrp group 3546 brief
sho hsrp group 3547 brief
sho hsrp group 3548 brief
sho hsrp group 3549 brief
sho hsrp group 3550 brief
sho hsrp group 3551 brief
sho hsrp group 3552 brief
sho hsrp group 3553 brief
sho hsrp group 3554 brief
sho hsrp group 3555 brief
sho hsrp group 3556 brief
sho hsrp group 3557 brief
sho hsrp group 3558 brief
sho hsrp group 3559 brief
sho hsrp group 3560 brief
sho hsrp group 3621 brief
sho hsrp group 3622 brief
sho hsrp group 3623 brief
sho hsrp group 3624 brief
sho hsrp group 3625 brief
sho hsrp group 3626 brief
sho hsrp group 3628 brief
sho hsrp group 3629 brief
sho hsrp group 3630 brief
sho hsrp group 3661 brief
sho hsrp group 3663 brief
sho hsrp group 3664 brief
sho hsrp group 3665 brief
sho hsrp group 3666 brief
sho hsrp group 3667 brief
sho hsrp group 3668 brief
sho hsrp group 3669 brief
sho hsrp group 3670 brief
sho hsrp group 3701 brief
sho hsrp group 3702 brief
sho hsrp group 3703 brief
sho hsrp group 3704 brief
sho hsrp group 3705 brief
sho hsrp group 3706 brief
sho hsrp group 3707 brief
sho hsrp group 3708 brief
sho hsrp group 3709 brief
sho hsrp group 3710 brief

# connected status #
sho ip route local | in 3101
sho ip route local | in 3102
sho ip route local | in 3103
sho ip route local | in 3104
sho ip route local | in 3105
sho ip route local | in 3106
sho ip route local | in 3107
sho ip route local | in 3108
sho ip route local | in 3110
sho ip route local | in 3111
sho ip route local | in 3112
sho ip route local | in 3113
sho ip route local | in 3114
sho ip route local | in 3115
sho ip route local | in 3116
sho ip route local | in 3118
sho ip route local | in 3119
sho ip route local | in 3120
sho ip route local | in 3121
sho ip route local | in 3122
sho ip route local | in 3123
sho ip route local | in 3124
sho ip route local | in 3125
sho ip route local | in 3117
sho ip route local | in 3202
sho ip route local | in 3203
sho ip route local | in 3204
sho ip route local | in 3205
sho ip route local | in 3206
sho ip route local | in 3207
sho ip route local | in 3208
sho ip route local | in 3209
sho ip route local | in 3210
sho ip route local | in 3201
sho ip route local | in 3242
sho ip route local | in 3244
sho ip route local | in 3245
sho ip route local | in 3246
sho ip route local | in 3247
sho ip route local | in 3248
sho ip route local | in 3249
sho ip route local | in 3250
sho ip route local | in 3281
sho ip route local | in 3282
sho ip route local | in 3283
sho ip route local | in 3285
sho ip route local | in 3501
sho ip route local | in 3502
sho ip route local | in 3503
sho ip route local | in 3504
sho ip route local | in 3505
sho ip route local | in 3506
sho ip route local | in 3507
sho ip route local | in 3508
sho ip route local | in 3509
sho ip route local | in 3510
sho ip route local | in 3541
sho ip route local | in 3542
sho ip route local | in 3543
sho ip route local | in 3544
sho ip route local | in 3545
sho ip route local | in 3546
sho ip route local | in 3547
sho ip route local | in 3548
sho ip route local | in 3549
sho ip route local | in 3550
sho ip route local | in 3551
sho ip route local | in 3552
sho ip route local | in 3553
sho ip route local | in 3554
sho ip route local | in 3555
sho ip route local | in 3556
sho ip route local | in 3557
sho ip route local | in 3558
sho ip route local | in 3559
sho ip route local | in 3560
sho ip route local | in 3621
sho ip route local | in 3622
sho ip route local | in 3623
sho ip route local | in 3624
sho ip route local | in 3625
sho ip route local | in 3626
sho ip route local | in 3628
sho ip route local | in 3629
sho ip route local | in 3630
sho ip route local | in 3661
sho ip route local | in 3663
sho ip route local | in 3664
sho ip route local | in 3665
sho ip route local | in 3666
sho ip route local | in 3667
sho ip route local | in 3668
sho ip route local | in 3669
sho ip route local | in 3670
sho ip route local | in 3701
sho ip route local | in 3702
sho ip route local | in 3703
sho ip route local | in 3704
sho ip route local | in 3705
sho ip route local | in 3706
sho ip route local | in 3707
sho ip route local | in 3708
sho ip route local | in 3709
sho ip route local | in 3710
```
---------------------
#### 設定変更
```rb
conf t
!
interface Vlan3101
 shut
interface Vlan3102
 shut
interface Vlan3103
 shut
interface Vlan3104
 shut
interface Vlan3105
 shut
interface Vlan3106
 shut
interface Vlan3107
 shut
interface Vlan3108
 shut
interface Vlan3110
 shut
interface Vlan3111
 shut
interface Vlan3112
 shut
interface Vlan3113
 shut
interface Vlan3114
 shut
interface Vlan3115
 shut
interface Vlan3116
 shut
interface Vlan3118
 shut
interface Vlan3119
 shut
interface Vlan3120
 shut
interface Vlan3121
 shut
interface Vlan3122
 shut
interface Vlan3123
 shut
interface Vlan3124
 shut
interface Vlan3125
 shut
interface Vlan3117
 shut
interface Vlan3202
 shut
interface Vlan3203
 shut
interface Vlan3204
 shut
interface Vlan3205
 shut
interface Vlan3206
 shut
interface Vlan3207
 shut
interface Vlan3208
 shut
interface Vlan3209
 shut
interface Vlan3210
 shut
interface Vlan3201
 shut
interface Vlan3242
 shut
interface Vlan3244
 shut
interface Vlan3245
 shut
interface Vlan3246
 shut
interface Vlan3247
 shut
interface Vlan3248
 shut
interface Vlan3249
 shut
interface Vlan3250
 shut
interface Vlan3281
 shut
interface Vlan3282
 shut
interface Vlan3283
 shut
interface Vlan3285
 shut
interface Vlan3501
 shut
interface Vlan3502
 shut
interface Vlan3503
 shut
interface Vlan3504
 shut
interface Vlan3505
 shut
interface Vlan3506
 shut
interface Vlan3507
 shut
interface Vlan3508
 shut
interface Vlan3509
 shut
interface Vlan3510
 shut
interface Vlan3541
 shut
interface Vlan3542
 shut
interface Vlan3543
 shut
interface Vlan3544
 shut
interface Vlan3545
 shut
interface Vlan3546
 shut
interface Vlan3547
 shut
interface Vlan3548
 shut
interface Vlan3549
 shut
interface Vlan3550
 shut
interface Vlan3551
 shut
interface Vlan3552
 shut
interface Vlan3553
 shut
interface Vlan3554
 shut
interface Vlan3555
 shut
interface Vlan3556
 shut
interface Vlan3557
 shut
interface Vlan3558
 shut
interface Vlan3559
 shut
interface Vlan3560
 shut
interface Vlan3621
 shut
interface Vlan3622
 shut
interface Vlan3623
 shut
interface Vlan3624
 shut
interface Vlan3625
 shut
interface Vlan3626
 shut
interface Vlan3628
 shut
interface Vlan3629
 shut
interface Vlan3630
 shut
interface Vlan3661
 shut
interface Vlan3663
 shut
interface Vlan3664
 shut
interface Vlan3665
 shut
interface Vlan3666
 shut
interface Vlan3667
 shut
interface Vlan3668
 shut
interface Vlan3669
 shut
interface Vlan3670
 shut
interface Vlan3701
 shut
interface Vlan3702
 shut
interface Vlan3703
 shut
interface Vlan3704
 shut
interface Vlan3705
 shut
interface Vlan3706
 shut
interface Vlan3707
 shut
interface Vlan3708
 shut
interface Vlan3709
 shut
interface Vlan3710
 shut
end
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 戻し考慮して IF　削除は後日実施
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Save
sho run diff
copy r s
```      
#### 作業後 確認
```rb
sho processes cpu | ex 0.0
sho logging last 50

# HSRP #
sho hsrp group 3101 brief
sho hsrp group 3102 brief
sho hsrp group 3103 brief
sho hsrp group 3104 brief
sho hsrp group 3105 brief
sho hsrp group 3106 brief
sho hsrp group 3107 brief
sho hsrp group 3108 brief
sho hsrp group 3110 brief
sho hsrp group 3111 brief
sho hsrp group 3112 brief
sho hsrp group 3113 brief
sho hsrp group 3114 brief
sho hsrp group 3115 brief
sho hsrp group 3116 brief
sho hsrp group 3118 brief
sho hsrp group 3119 brief
sho hsrp group 3120 brief
sho hsrp group 3121 brief
sho hsrp group 3122 brief
sho hsrp group 3123 brief
sho hsrp group 3124 brief
sho hsrp group 3125 brief
sho hsrp group 3117 brief
sho hsrp group 3202 brief
sho hsrp group 3203 brief
sho hsrp group 3204 brief
sho hsrp group 3205 brief
sho hsrp group 3206 brief
sho hsrp group 3207 brief
sho hsrp group 3208 brief
sho hsrp group 3209 brief
sho hsrp group 3210 brief
sho hsrp group 3201 brief
sho hsrp group 3242 brief
sho hsrp group 3244 brief
sho hsrp group 3245 brief
sho hsrp group 3246 brief
sho hsrp group 3247 brief
sho hsrp group 3248 brief
sho hsrp group 3249 brief
sho hsrp group 3250 brief
sho hsrp group 3281 brief
sho hsrp group 3282 brief
sho hsrp group 3283 brief
sho hsrp group 3285 brief
sho hsrp group 3501 brief
sho hsrp group 3502 brief
sho hsrp group 3503 brief
sho hsrp group 3504 brief
sho hsrp group 3505 brief
sho hsrp group 3506 brief
sho hsrp group 3507 brief
sho hsrp group 3508 brief
sho hsrp group 3509 brief
sho hsrp group 3510 brief
sho hsrp group 3541 brief
sho hsrp group 3542 brief
sho hsrp group 3543 brief
sho hsrp group 3544 brief
sho hsrp group 3545 brief
sho hsrp group 3546 brief
sho hsrp group 3547 brief
sho hsrp group 3548 brief
sho hsrp group 3549 brief
sho hsrp group 3550 brief
sho hsrp group 3551 brief
sho hsrp group 3552 brief
sho hsrp group 3553 brief
sho hsrp group 3554 brief
sho hsrp group 3555 brief
sho hsrp group 3556 brief
sho hsrp group 3557 brief
sho hsrp group 3558 brief
sho hsrp group 3559 brief
sho hsrp group 3560 brief
sho hsrp group 3621 brief
sho hsrp group 3622 brief
sho hsrp group 3623 brief
sho hsrp group 3624 brief
sho hsrp group 3625 brief
sho hsrp group 3626 brief
sho hsrp group 3628 brief
sho hsrp group 3629 brief
sho hsrp group 3630 brief
sho hsrp group 3661 brief
sho hsrp group 3663 brief
sho hsrp group 3664 brief
sho hsrp group 3665 brief
sho hsrp group 3666 brief
sho hsrp group 3667 brief
sho hsrp group 3668 brief
sho hsrp group 3669 brief
sho hsrp group 3670 brief
sho hsrp group 3701 brief
sho hsrp group 3702 brief
sho hsrp group 3703 brief
sho hsrp group 3704 brief
sho hsrp group 3705 brief
sho hsrp group 3706 brief
sho hsrp group 3707 brief
sho hsrp group 3708 brief
sho hsrp group 3709 brief
sho hsrp group 3710 brief

# ARP #
sho ip arp | in 10.26.1.254
sho ip arp | in 10.26.2.254
sho ip arp | in 10.26.3.254
sho ip arp | in 10.26.4.254
sho ip arp | in 10.26.5.254
sho ip arp | in 10.26.6.254
sho ip arp | in 10.26.7.254
sho ip arp | in 10.26.8.254
sho ip arp | in 10.26.10.254
sho ip arp | in 10.26.11.254
sho ip arp | in 10.26.12.254
sho ip arp | in 10.26.13.254
sho ip arp | in 10.26.14.254
sho ip arp | in 10.26.15.254
sho ip arp | in 10.26.16.254
sho ip arp | in 10.26.18.254
sho ip arp | in 10.26.19.254
sho ip arp | in 10.26.20.254
sho ip arp | in 10.26.21.254
sho ip arp | in 10.26.22.254
sho ip arp | in 10.26.23.254
sho ip arp | in 10.26.24.254
sho ip arp | in 10.26.25.254
sho ip arp | in 10.26.17.254
sho ip arp | in 10.26.27.254
sho ip arp | in 10.26.28.254
sho ip arp | in 10.26.29.254
sho ip arp | in 10.26.30.254
sho ip arp | in 10.26.31.254
sho ip arp | in 10.26.39.254
sho ip arp | in 10.26.40.254
sho ip arp | in 10.26.41.254
sho ip arp | in 10.26.42.254
sho ip arp | in 10.26.26.254
sho ip arp | in 10.26.44.254
sho ip arp | in 10.26.46.254
sho ip arp | in 10.26.47.254
sho ip arp | in 10.26.48.254
sho ip arp | in 10.26.49.254
sho ip arp | in 10.26.50.254
sho ip arp | in 10.26.51.254
sho ip arp | in 10.26.52.254
sho ip arp | in 10.26.53.254
sho ip arp | in 10.26.54.254
sho ip arp | in 10.26.55.254
sho ip arp | in 10.26.57.254
sho ip arp | in 10.26.58.254
sho ip arp | in 10.26.59.254
sho ip arp | in 10.26.60.254
sho ip arp | in 10.26.61.254
sho ip arp | in 10.26.62.254
sho ip arp | in 10.26.63.254
sho ip arp | in 10.26.64.254
sho ip arp | in 10.26.65.254
sho ip arp | in 10.26.66.254
sho ip arp | in 10.26.67.254
sho ip arp | in 10.26.68.254
sho ip arp | in 10.26.69.254
sho ip arp | in 10.26.70.254
sho ip arp | in 10.26.71.254
sho ip arp | in 10.26.72.254
sho ip arp | in 10.26.73.254
sho ip arp | in 10.26.74.254
sho ip arp | in 10.26.75.254
sho ip arp | in 10.26.76.254
sho ip arp | in 10.26.77.254
sho ip arp | in 10.26.78.254
sho ip arp | in 10.26.79.254
sho ip arp | in 10.26.80.254
sho ip arp | in 10.26.81.254
sho ip arp | in 10.26.82.254
sho ip arp | in 10.26.83.254
sho ip arp | in 10.26.84.254
sho ip arp | in 10.26.85.254
sho ip arp | in 10.26.86.254
sho ip arp | in 10.26.87.254
sho ip arp | in 10.26.88.254
sho ip arp | in 10.26.89.254
sho ip arp | in 10.26.90.254
sho ip arp | in 10.26.91.254
sho ip arp | in 10.26.92.254
sho ip arp | in 10.26.93.254
sho ip arp | in 10.26.95.254
sho ip arp | in 10.26.96.254
sho ip arp | in 10.26.97.254
sho ip arp | in 10.26.98.254
sho ip arp | in 10.26.100.254
sho ip arp | in 10.26.101.254
sho ip arp | in 10.26.102.254
sho ip arp | in 10.26.103.254
sho ip arp | in 10.26.104.254
sho ip arp | in 10.26.105.254
sho ip arp | in 10.26.106.254
sho ip arp | in 10.26.107.254
sho ip arp | in 10.26.108.254
sho ip arp | in 10.26.109.254
sho ip arp | in 10.26.110.254
sho ip arp | in 10.26.111.254
sho ip arp | in 10.26.112.254
sho ip arp | in 10.26.113.254
sho ip arp | in 10.26.114.254
sho ip arp | in 10.26.115.254
sho ip arp | in 10.26.116.254
sho ip arp | in 10.26.117.254

# テーブル DirectCennect から消えてるか
sho ip route local | in 3101
sho ip route local | in 3102
sho ip route local | in 3103
sho ip route local | in 3104
sho ip route local | in 3105
sho ip route local | in 3106
sho ip route local | in 3107
sho ip route local | in 3108
sho ip route local | in 3110
sho ip route local | in 3111
sho ip route local | in 3112
sho ip route local | in 3113
sho ip route local | in 3114
sho ip route local | in 3115
sho ip route local | in 3116
sho ip route local | in 3118
sho ip route local | in 3119
sho ip route local | in 3120
sho ip route local | in 3121
sho ip route local | in 3122
sho ip route local | in 3123
sho ip route local | in 3124
sho ip route local | in 3125
sho ip route local | in 3117
sho ip route local | in 3202
sho ip route local | in 3203
sho ip route local | in 3204
sho ip route local | in 3205
sho ip route local | in 3206
sho ip route local | in 3207
sho ip route local | in 3208
sho ip route local | in 3209
sho ip route local | in 3210
sho ip route local | in 3201
sho ip route local | in 3242
sho ip route local | in 3244
sho ip route local | in 3245
sho ip route local | in 3246
sho ip route local | in 3247
sho ip route local | in 3248
sho ip route local | in 3249
sho ip route local | in 3250
sho ip route local | in 3281
sho ip route local | in 3282
sho ip route local | in 3283
sho ip route local | in 3285
sho ip route local | in 3501
sho ip route local | in 3502
sho ip route local | in 3503
sho ip route local | in 3504
sho ip route local | in 3505
sho ip route local | in 3506
sho ip route local | in 3507
sho ip route local | in 3508
sho ip route local | in 3509
sho ip route local | in 3510
sho ip route local | in 3541
sho ip route local | in 3542
sho ip route local | in 3543
sho ip route local | in 3544
sho ip route local | in 3545
sho ip route local | in 3546
sho ip route local | in 3547
sho ip route local | in 3548
sho ip route local | in 3549
sho ip route local | in 3550
sho ip route local | in 3551
sho ip route local | in 3552
sho ip route local | in 3553
sho ip route local | in 3554
sho ip route local | in 3555
sho ip route local | in 3556
sho ip route local | in 3557
sho ip route local | in 3558
sho ip route local | in 3559
sho ip route local | in 3560
sho ip route local | in 3621
sho ip route local | in 3622
sho ip route local | in 3623
sho ip route local | in 3624
sho ip route local | in 3625
sho ip route local | in 3626
sho ip route local | in 3628
sho ip route local | in 3629
sho ip route local | in 3630
sho ip route local | in 3661
sho ip route local | in 3663
sho ip route local | in 3664
sho ip route local | in 3665
sho ip route local | in 3666
sho ip route local | in 3667
sho ip route local | in 3668
sho ip route local | in 3669
sho ip route local | in 3670
sho ip route local | in 3701
sho ip route local | in 3702
sho ip route local | in 3703
sho ip route local | in 3704
sho ip route local | in 3705
sho ip route local | in 3706
sho ip route local | in 3707
sho ip route local | in 3708
sho ip route local | in 3709
sho ip route local | in 3710
```
------------------------

### 2-2 【メンテ当日】DC1 SpineのGWの設定を消す（回線断）
### [21K1032-3FJ17-NX9272-01 / 10.102.5.1 ](https://docs.google.com/spreadsheets/d/1TvojSd9qo_HbC_H88KLRNzfZqlq6YCt90lfRstQcqvk/edit#gid=1167760439&range=I624)  
#### 事前確認
```rb
# Diff #
sho run diff

# Checkpoint # 
sho checkpoint summary
適宜 >> #clear checkpoint database user
checkpoint stable
sho diff rollback-patch checkpoint stable running-config

# CPU #
sho processes cpu | ex 0.0

# LOG #
sho logging last 50

# ARP GW MACアドレスがCiscoであること #
sho ip arp | in 10.26.1.254
sho ip arp | in 10.26.2.254
sho ip arp | in 10.26.3.254
sho ip arp | in 10.26.4.254
sho ip arp | in 10.26.5.254
sho ip arp | in 10.26.6.254
sho ip arp | in 10.26.7.254
sho ip arp | in 10.26.8.254
sho ip arp | in 10.26.10.254
sho ip arp | in 10.26.11.254
sho ip arp | in 10.26.12.254
sho ip arp | in 10.26.13.254
sho ip arp | in 10.26.14.254
sho ip arp | in 10.26.15.254
sho ip arp | in 10.26.16.254
sho ip arp | in 10.26.18.254
sho ip arp | in 10.26.19.254
sho ip arp | in 10.26.20.254
sho ip arp | in 10.26.21.254
sho ip arp | in 10.26.22.254
sho ip arp | in 10.26.23.254
sho ip arp | in 10.26.24.254
sho ip arp | in 10.26.25.254
sho ip arp | in 10.26.17.254
sho ip arp | in 10.26.27.254
sho ip arp | in 10.26.28.254
sho ip arp | in 10.26.29.254
sho ip arp | in 10.26.30.254
sho ip arp | in 10.26.31.254
sho ip arp | in 10.26.39.254
sho ip arp | in 10.26.40.254
sho ip arp | in 10.26.41.254
sho ip arp | in 10.26.42.254
sho ip arp | in 10.26.26.254
sho ip arp | in 10.26.44.254
sho ip arp | in 10.26.46.254
sho ip arp | in 10.26.47.254
sho ip arp | in 10.26.48.254
sho ip arp | in 10.26.49.254
sho ip arp | in 10.26.50.254
sho ip arp | in 10.26.51.254
sho ip arp | in 10.26.52.254
sho ip arp | in 10.26.53.254
sho ip arp | in 10.26.54.254
sho ip arp | in 10.26.55.254
sho ip arp | in 10.26.57.254
sho ip arp | in 10.26.58.254
sho ip arp | in 10.26.59.254
sho ip arp | in 10.26.60.254
sho ip arp | in 10.26.61.254
sho ip arp | in 10.26.62.254
sho ip arp | in 10.26.63.254
sho ip arp | in 10.26.64.254
sho ip arp | in 10.26.65.254
sho ip arp | in 10.26.66.254
sho ip arp | in 10.26.67.254
sho ip arp | in 10.26.68.254
sho ip arp | in 10.26.69.254
sho ip arp | in 10.26.70.254
sho ip arp | in 10.26.71.254
sho ip arp | in 10.26.72.254
sho ip arp | in 10.26.73.254
sho ip arp | in 10.26.74.254
sho ip arp | in 10.26.75.254
sho ip arp | in 10.26.76.254
sho ip arp | in 10.26.77.254
sho ip arp | in 10.26.78.254
sho ip arp | in 10.26.79.254
sho ip arp | in 10.26.80.254
sho ip arp | in 10.26.81.254
sho ip arp | in 10.26.82.254
sho ip arp | in 10.26.83.254
sho ip arp | in 10.26.84.254
sho ip arp | in 10.26.85.254
sho ip arp | in 10.26.86.254
sho ip arp | in 10.26.87.254
sho ip arp | in 10.26.88.254
sho ip arp | in 10.26.89.254
sho ip arp | in 10.26.90.254
sho ip arp | in 10.26.91.254
sho ip arp | in 10.26.92.254
sho ip arp | in 10.26.93.254
sho ip arp | in 10.26.95.254
sho ip arp | in 10.26.96.254
sho ip arp | in 10.26.97.254
sho ip arp | in 10.26.98.254
sho ip arp | in 10.26.100.254
sho ip arp | in 10.26.101.254
sho ip arp | in 10.26.102.254
sho ip arp | in 10.26.103.254
sho ip arp | in 10.26.104.254
sho ip arp | in 10.26.105.254
sho ip arp | in 10.26.106.254
sho ip arp | in 10.26.107.254
sho ip arp | in 10.26.108.254
sho ip arp | in 10.26.109.254
sho ip arp | in 10.26.110.254
sho ip arp | in 10.26.111.254
sho ip arp | in 10.26.112.254
sho ip arp | in 10.26.113.254
sho ip arp | in 10.26.114.254
sho ip arp | in 10.26.115.254
sho ip arp | in 10.26.116.254
sho ip arp | in 10.26.117.254

# HSRP #
sho hsrp group 3101 brief
sho hsrp group 3102 brief
sho hsrp group 3103 brief
sho hsrp group 3104 brief
sho hsrp group 3105 brief
sho hsrp group 3106 brief
sho hsrp group 3107 brief
sho hsrp group 3108 brief
sho hsrp group 3110 brief
sho hsrp group 3111 brief
sho hsrp group 3112 brief
sho hsrp group 3113 brief
sho hsrp group 3114 brief
sho hsrp group 3115 brief
sho hsrp group 3116 brief
sho hsrp group 3118 brief
sho hsrp group 3119 brief
sho hsrp group 3120 brief
sho hsrp group 3121 brief
sho hsrp group 3122 brief
sho hsrp group 3123 brief
sho hsrp group 3124 brief
sho hsrp group 3125 brief
sho hsrp group 3117 brief
sho hsrp group 3202 brief
sho hsrp group 3203 brief
sho hsrp group 3204 brief
sho hsrp group 3205 brief
sho hsrp group 3206 brief
sho hsrp group 3207 brief
sho hsrp group 3208 brief
sho hsrp group 3209 brief
sho hsrp group 3210 brief
sho hsrp group 3201 brief
sho hsrp group 3242 brief
sho hsrp group 3244 brief
sho hsrp group 3245 brief
sho hsrp group 3246 brief
sho hsrp group 3247 brief
sho hsrp group 3248 brief
sho hsrp group 3249 brief
sho hsrp group 3250 brief
sho hsrp group 3281 brief
sho hsrp group 3282 brief
sho hsrp group 3283 brief
sho hsrp group 3285 brief
sho hsrp group 3501 brief
sho hsrp group 3502 brief
sho hsrp group 3503 brief
sho hsrp group 3504 brief
sho hsrp group 3505 brief
sho hsrp group 3506 brief
sho hsrp group 3507 brief
sho hsrp group 3508 brief
sho hsrp group 3509 brief
sho hsrp group 3510 brief
sho hsrp group 3541 brief
sho hsrp group 3542 brief
sho hsrp group 3543 brief
sho hsrp group 3544 brief
sho hsrp group 3545 brief
sho hsrp group 3546 brief
sho hsrp group 3547 brief
sho hsrp group 3548 brief
sho hsrp group 3549 brief
sho hsrp group 3550 brief
sho hsrp group 3551 brief
sho hsrp group 3552 brief
sho hsrp group 3553 brief
sho hsrp group 3554 brief
sho hsrp group 3555 brief
sho hsrp group 3556 brief
sho hsrp group 3557 brief
sho hsrp group 3558 brief
sho hsrp group 3559 brief
sho hsrp group 3560 brief
sho hsrp group 3621 brief
sho hsrp group 3622 brief
sho hsrp group 3623 brief
sho hsrp group 3624 brief
sho hsrp group 3625 brief
sho hsrp group 3626 brief
sho hsrp group 3628 brief
sho hsrp group 3629 brief
sho hsrp group 3630 brief
sho hsrp group 3661 brief
sho hsrp group 3663 brief
sho hsrp group 3664 brief
sho hsrp group 3665 brief
sho hsrp group 3666 brief
sho hsrp group 3667 brief
sho hsrp group 3668 brief
sho hsrp group 3669 brief
sho hsrp group 3670 brief
sho hsrp group 3701 brief
sho hsrp group 3702 brief
sho hsrp group 3703 brief
sho hsrp group 3704 brief
sho hsrp group 3705 brief
sho hsrp group 3706 brief
sho hsrp group 3707 brief
sho hsrp group 3708 brief
sho hsrp group 3709 brief
sho hsrp group 3710 brief

# connected status #
sho ip route local | in 3101
sho ip route local | in 3102
sho ip route local | in 3103
sho ip route local | in 3104
sho ip route local | in 3105
sho ip route local | in 3106
sho ip route local | in 3107
sho ip route local | in 3108
sho ip route local | in 3110
sho ip route local | in 3111
sho ip route local | in 3112
sho ip route local | in 3113
sho ip route local | in 3114
sho ip route local | in 3115
sho ip route local | in 3116
sho ip route local | in 3118
sho ip route local | in 3119
sho ip route local | in 3120
sho ip route local | in 3121
sho ip route local | in 3122
sho ip route local | in 3123
sho ip route local | in 3124
sho ip route local | in 3125
sho ip route local | in 3117
sho ip route local | in 3202
sho ip route local | in 3203
sho ip route local | in 3204
sho ip route local | in 3205
sho ip route local | in 3206
sho ip route local | in 3207
sho ip route local | in 3208
sho ip route local | in 3209
sho ip route local | in 3210
sho ip route local | in 3201
sho ip route local | in 3242
sho ip route local | in 3244
sho ip route local | in 3245
sho ip route local | in 3246
sho ip route local | in 3247
sho ip route local | in 3248
sho ip route local | in 3249
sho ip route local | in 3250
sho ip route local | in 3281
sho ip route local | in 3282
sho ip route local | in 3283
sho ip route local | in 3285
sho ip route local | in 3501
sho ip route local | in 3502
sho ip route local | in 3503
sho ip route local | in 3504
sho ip route local | in 3505
sho ip route local | in 3506
sho ip route local | in 3507
sho ip route local | in 3508
sho ip route local | in 3509
sho ip route local | in 3510
sho ip route local | in 3541
sho ip route local | in 3542
sho ip route local | in 3543
sho ip route local | in 3544
sho ip route local | in 3545
sho ip route local | in 3546
sho ip route local | in 3547
sho ip route local | in 3548
sho ip route local | in 3549
sho ip route local | in 3550
sho ip route local | in 3551
sho ip route local | in 3552
sho ip route local | in 3553
sho ip route local | in 3554
sho ip route local | in 3555
sho ip route local | in 3556
sho ip route local | in 3557
sho ip route local | in 3558
sho ip route local | in 3559
sho ip route local | in 3560
sho ip route local | in 3621
sho ip route local | in 3622
sho ip route local | in 3623
sho ip route local | in 3624
sho ip route local | in 3625
sho ip route local | in 3626
sho ip route local | in 3628
sho ip route local | in 3629
sho ip route local | in 3630
sho ip route local | in 3661
sho ip route local | in 3663
sho ip route local | in 3664
sho ip route local | in 3665
sho ip route local | in 3666
sho ip route local | in 3667
sho ip route local | in 3668
sho ip route local | in 3669
sho ip route local | in 3670
sho ip route local | in 3701
sho ip route local | in 3702
sho ip route local | in 3703
sho ip route local | in 3704
sho ip route local | in 3705
sho ip route local | in 3706
sho ip route local | in 3707
sho ip route local | in 3708
sho ip route local | in 3709
sho ip route local | in 3710
```
---
#### 設定変更
```rb
conf t
!
interface Vlan3101
 shut
interface Vlan3102
 shut
interface Vlan3103
 shut
interface Vlan3104
 shut
interface Vlan3105
 shut
interface Vlan3106
 shut
interface Vlan3107
 shut
interface Vlan3108
 shut
interface Vlan3110
 shut
interface Vlan3111
 shut
interface Vlan3112
 shut
interface Vlan3113
 shut
interface Vlan3114
 shut
interface Vlan3115
 shut
interface Vlan3116
 shut
interface Vlan3118
 shut
interface Vlan3119
 shut
interface Vlan3120
 shut
interface Vlan3121
 shut
interface Vlan3122
 shut
interface Vlan3123
 shut
interface Vlan3124
 shut
interface Vlan3125
 shut
interface Vlan3117
 shut
interface Vlan3202
 shut
interface Vlan3203
 shut
interface Vlan3204
 shut
interface Vlan3205
 shut
interface Vlan3206
 shut
interface Vlan3207
 shut
interface Vlan3208
 shut
interface Vlan3209
 shut
interface Vlan3210
 shut
interface Vlan3201
 shut
interface Vlan3242
 shut
interface Vlan3244
 shut
interface Vlan3245
 shut
interface Vlan3246
 shut
interface Vlan3247
 shut
interface Vlan3248
 shut
interface Vlan3249
 shut
interface Vlan3250
 shut
interface Vlan3281
 shut
interface Vlan3282
 shut
interface Vlan3283
 shut
interface Vlan3285
 shut
interface Vlan3501
 shut
interface Vlan3502
 shut
interface Vlan3503
 shut
interface Vlan3504
 shut
interface Vlan3505
 shut
interface Vlan3506
 shut
interface Vlan3507
 shut
interface Vlan3508
 shut
interface Vlan3509
 shut
interface Vlan3510
 shut
interface Vlan3541
 shut
interface Vlan3542
 shut
interface Vlan3543
 shut
interface Vlan3544
 shut
interface Vlan3545
 shut
interface Vlan3546
 shut
interface Vlan3547
 shut
interface Vlan3548
 shut
interface Vlan3549
 shut
interface Vlan3550
 shut
interface Vlan3551
 shut
interface Vlan3552
 shut
interface Vlan3553
 shut
interface Vlan3554
 shut
interface Vlan3555
 shut
interface Vlan3556
 shut
interface Vlan3557
 shut
interface Vlan3558
 shut
interface Vlan3559
 shut
interface Vlan3560
 shut
interface Vlan3621
 shut
interface Vlan3622
 shut
interface Vlan3623
 shut
interface Vlan3624
 shut
interface Vlan3625
 shut
interface Vlan3626
 shut
interface Vlan3628
 shut
interface Vlan3629
 shut
interface Vlan3630
 shut
interface Vlan3661
 shut
interface Vlan3663
 shut
interface Vlan3664
 shut
interface Vlan3665
 shut
interface Vlan3666
 shut
interface Vlan3667
 shut
interface Vlan3668
 shut
interface Vlan3669
 shut
interface Vlan3670
 shut
interface Vlan3701
 shut
interface Vlan3702
 shut
interface Vlan3703
 shut
interface Vlan3704
 shut
interface Vlan3705
 shut
interface Vlan3706
 shut
interface Vlan3707
 shut
interface Vlan3708
 shut
interface Vlan3709
 shut
interface Vlan3710
 shut
end
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 戻し考慮して IF　削除は後日実施
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Save
sho run diff
copy r s
```      
#### 作業後 確認
```rb
sho processes cpu | ex 0.0
sho logging last 50

# HSRP #
sho hsrp group 3101 brief
sho hsrp group 3102 brief
sho hsrp group 3103 brief
sho hsrp group 3104 brief
sho hsrp group 3105 brief
sho hsrp group 3106 brief
sho hsrp group 3107 brief
sho hsrp group 3108 brief
sho hsrp group 3110 brief
sho hsrp group 3111 brief
sho hsrp group 3112 brief
sho hsrp group 3113 brief
sho hsrp group 3114 brief
sho hsrp group 3115 brief
sho hsrp group 3116 brief
sho hsrp group 3118 brief
sho hsrp group 3119 brief
sho hsrp group 3120 brief
sho hsrp group 3121 brief
sho hsrp group 3122 brief
sho hsrp group 3123 brief
sho hsrp group 3124 brief
sho hsrp group 3125 brief
sho hsrp group 3117 brief
sho hsrp group 3202 brief
sho hsrp group 3203 brief
sho hsrp group 3204 brief
sho hsrp group 3205 brief
sho hsrp group 3206 brief
sho hsrp group 3207 brief
sho hsrp group 3208 brief
sho hsrp group 3209 brief
sho hsrp group 3210 brief
sho hsrp group 3201 brief
sho hsrp group 3242 brief
sho hsrp group 3244 brief
sho hsrp group 3245 brief
sho hsrp group 3246 brief
sho hsrp group 3247 brief
sho hsrp group 3248 brief
sho hsrp group 3249 brief
sho hsrp group 3250 brief
sho hsrp group 3281 brief
sho hsrp group 3282 brief
sho hsrp group 3283 brief
sho hsrp group 3285 brief
sho hsrp group 3501 brief
sho hsrp group 3502 brief
sho hsrp group 3503 brief
sho hsrp group 3504 brief
sho hsrp group 3505 brief
sho hsrp group 3506 brief
sho hsrp group 3507 brief
sho hsrp group 3508 brief
sho hsrp group 3509 brief
sho hsrp group 3510 brief
sho hsrp group 3541 brief
sho hsrp group 3542 brief
sho hsrp group 3543 brief
sho hsrp group 3544 brief
sho hsrp group 3545 brief
sho hsrp group 3546 brief
sho hsrp group 3547 brief
sho hsrp group 3548 brief
sho hsrp group 3549 brief
sho hsrp group 3550 brief
sho hsrp group 3551 brief
sho hsrp group 3552 brief
sho hsrp group 3553 brief
sho hsrp group 3554 brief
sho hsrp group 3555 brief
sho hsrp group 3556 brief
sho hsrp group 3557 brief
sho hsrp group 3558 brief
sho hsrp group 3559 brief
sho hsrp group 3560 brief
sho hsrp group 3621 brief
sho hsrp group 3622 brief
sho hsrp group 3623 brief
sho hsrp group 3624 brief
sho hsrp group 3625 brief
sho hsrp group 3626 brief
sho hsrp group 3628 brief
sho hsrp group 3629 brief
sho hsrp group 3630 brief
sho hsrp group 3661 brief
sho hsrp group 3663 brief
sho hsrp group 3664 brief
sho hsrp group 3665 brief
sho hsrp group 3666 brief
sho hsrp group 3667 brief
sho hsrp group 3668 brief
sho hsrp group 3669 brief
sho hsrp group 3670 brief
sho hsrp group 3701 brief
sho hsrp group 3702 brief
sho hsrp group 3703 brief
sho hsrp group 3704 brief
sho hsrp group 3705 brief
sho hsrp group 3706 brief
sho hsrp group 3707 brief
sho hsrp group 3708 brief
sho hsrp group 3709 brief
sho hsrp group 3710 brief

# ARP #
sho ip arp | in 10.26.1.254
sho ip arp | in 10.26.2.254
sho ip arp | in 10.26.3.254
sho ip arp | in 10.26.4.254
sho ip arp | in 10.26.5.254
sho ip arp | in 10.26.6.254
sho ip arp | in 10.26.7.254
sho ip arp | in 10.26.8.254
sho ip arp | in 10.26.10.254
sho ip arp | in 10.26.11.254
sho ip arp | in 10.26.12.254
sho ip arp | in 10.26.13.254
sho ip arp | in 10.26.14.254
sho ip arp | in 10.26.15.254
sho ip arp | in 10.26.16.254
sho ip arp | in 10.26.18.254
sho ip arp | in 10.26.19.254
sho ip arp | in 10.26.20.254
sho ip arp | in 10.26.21.254
sho ip arp | in 10.26.22.254
sho ip arp | in 10.26.23.254
sho ip arp | in 10.26.24.254
sho ip arp | in 10.26.25.254
sho ip arp | in 10.26.17.254
sho ip arp | in 10.26.27.254
sho ip arp | in 10.26.28.254
sho ip arp | in 10.26.29.254
sho ip arp | in 10.26.30.254
sho ip arp | in 10.26.31.254
sho ip arp | in 10.26.39.254
sho ip arp | in 10.26.40.254
sho ip arp | in 10.26.41.254
sho ip arp | in 10.26.42.254
sho ip arp | in 10.26.26.254
sho ip arp | in 10.26.44.254
sho ip arp | in 10.26.46.254
sho ip arp | in 10.26.47.254
sho ip arp | in 10.26.48.254
sho ip arp | in 10.26.49.254
sho ip arp | in 10.26.50.254
sho ip arp | in 10.26.51.254
sho ip arp | in 10.26.52.254
sho ip arp | in 10.26.53.254
sho ip arp | in 10.26.54.254
sho ip arp | in 10.26.55.254
sho ip arp | in 10.26.57.254
sho ip arp | in 10.26.58.254
sho ip arp | in 10.26.59.254
sho ip arp | in 10.26.60.254
sho ip arp | in 10.26.61.254
sho ip arp | in 10.26.62.254
sho ip arp | in 10.26.63.254
sho ip arp | in 10.26.64.254
sho ip arp | in 10.26.65.254
sho ip arp | in 10.26.66.254
sho ip arp | in 10.26.67.254
sho ip arp | in 10.26.68.254
sho ip arp | in 10.26.69.254
sho ip arp | in 10.26.70.254
sho ip arp | in 10.26.71.254
sho ip arp | in 10.26.72.254
sho ip arp | in 10.26.73.254
sho ip arp | in 10.26.74.254
sho ip arp | in 10.26.75.254
sho ip arp | in 10.26.76.254
sho ip arp | in 10.26.77.254
sho ip arp | in 10.26.78.254
sho ip arp | in 10.26.79.254
sho ip arp | in 10.26.80.254
sho ip arp | in 10.26.81.254
sho ip arp | in 10.26.82.254
sho ip arp | in 10.26.83.254
sho ip arp | in 10.26.84.254
sho ip arp | in 10.26.85.254
sho ip arp | in 10.26.86.254
sho ip arp | in 10.26.87.254
sho ip arp | in 10.26.88.254
sho ip arp | in 10.26.89.254
sho ip arp | in 10.26.90.254
sho ip arp | in 10.26.91.254
sho ip arp | in 10.26.92.254
sho ip arp | in 10.26.93.254
sho ip arp | in 10.26.95.254
sho ip arp | in 10.26.96.254
sho ip arp | in 10.26.97.254
sho ip arp | in 10.26.98.254
sho ip arp | in 10.26.100.254
sho ip arp | in 10.26.101.254
sho ip arp | in 10.26.102.254
sho ip arp | in 10.26.103.254
sho ip arp | in 10.26.104.254
sho ip arp | in 10.26.105.254
sho ip arp | in 10.26.106.254
sho ip arp | in 10.26.107.254
sho ip arp | in 10.26.108.254
sho ip arp | in 10.26.109.254
sho ip arp | in 10.26.110.254
sho ip arp | in 10.26.111.254
sho ip arp | in 10.26.112.254
sho ip arp | in 10.26.113.254
sho ip arp | in 10.26.114.254
sho ip arp | in 10.26.115.254
sho ip arp | in 10.26.116.254
sho ip arp | in 10.26.117.254

# テーブル DirectCennect から消えてるか
sho ip route local | in 3101
sho ip route local | in 3102
sho ip route local | in 3103
sho ip route local | in 3104
sho ip route local | in 3105
sho ip route local | in 3106
sho ip route local | in 3107
sho ip route local | in 3108
sho ip route local | in 3110
sho ip route local | in 3111
sho ip route local | in 3112
sho ip route local | in 3113
sho ip route local | in 3114
sho ip route local | in 3115
sho ip route local | in 3116
sho ip route local | in 3118
sho ip route local | in 3119
sho ip route local | in 3120
sho ip route local | in 3121
sho ip route local | in 3122
sho ip route local | in 3123
sho ip route local | in 3124
sho ip route local | in 3125
sho ip route local | in 3117
sho ip route local | in 3202
sho ip route local | in 3203
sho ip route local | in 3204
sho ip route local | in 3205
sho ip route local | in 3206
sho ip route local | in 3207
sho ip route local | in 3208
sho ip route local | in 3209
sho ip route local | in 3210
sho ip route local | in 3201
sho ip route local | in 3242
sho ip route local | in 3244
sho ip route local | in 3245
sho ip route local | in 3246
sho ip route local | in 3247
sho ip route local | in 3248
sho ip route local | in 3249
sho ip route local | in 3250
sho ip route local | in 3281
sho ip route local | in 3282
sho ip route local | in 3283
sho ip route local | in 3285
sho ip route local | in 3501
sho ip route local | in 3502
sho ip route local | in 3503
sho ip route local | in 3504
sho ip route local | in 3505
sho ip route local | in 3506
sho ip route local | in 3507
sho ip route local | in 3508
sho ip route local | in 3509
sho ip route local | in 3510
sho ip route local | in 3541
sho ip route local | in 3542
sho ip route local | in 3543
sho ip route local | in 3544
sho ip route local | in 3545
sho ip route local | in 3546
sho ip route local | in 3547
sho ip route local | in 3548
sho ip route local | in 3549
sho ip route local | in 3550
sho ip route local | in 3551
sho ip route local | in 3552
sho ip route local | in 3553
sho ip route local | in 3554
sho ip route local | in 3555
sho ip route local | in 3556
sho ip route local | in 3557
sho ip route local | in 3558
sho ip route local | in 3559
sho ip route local | in 3560
sho ip route local | in 3621
sho ip route local | in 3622
sho ip route local | in 3623
sho ip route local | in 3624
sho ip route local | in 3625
sho ip route local | in 3626
sho ip route local | in 3628
sho ip route local | in 3629
sho ip route local | in 3630
sho ip route local | in 3661
sho ip route local | in 3663
sho ip route local | in 3664
sho ip route local | in 3665
sho ip route local | in 3666
sho ip route local | in 3667
sho ip route local | in 3668
sho ip route local | in 3669
sho ip route local | in 3670
sho ip route local | in 3701
sho ip route local | in 3702
sho ip route local | in 3703
sho ip route local | in 3704
sho ip route local | in 3705
sho ip route local | in 3706
sho ip route local | in 3707
sho ip route local | in 3708
sho ip route local | in 3709
sho ip route local | in 3710

```
---
#### 👼👼👼ロールバック👼👼👼
```rb
# Diff #
sho diff rollback-patch checkpoint stable running-config

# Rollback #
rollback running-config checkpoint stable
```      
---
------------------------
### 3. 【メンテ当日】DC6 Spineの Vlan IFを有効にする
### [22K2039-K2D022-CE8850 / 10.81.0.13 ](https://docs.google.com/spreadsheets/d/1b3y44zG8fqMLKzecoCpmpUxvp5d1A0eVsMhXfsREq8A/edit#gid=1167760439&range=D21)  
#### 事前確認
```rb
# Diff #
dis conf cha

# Log # 
dis logbuffer

# CPU #
dis cpu

# ARP #
# 作業前なので表示無し
display arp | in 10.26.1.254
display arp | in 10.26.2.254
display arp | in 10.26.3.254
display arp | in 10.26.4.254
display arp | in 10.26.5.254
display arp | in 10.26.6.254
display arp | in 10.26.7.254
display arp | in 10.26.8.254
display arp | in 10.26.10.254
display arp | in 10.26.11.254
display arp | in 10.26.12.254
display arp | in 10.26.13.254
display arp | in 10.26.14.254
display arp | in 10.26.15.254
display arp | in 10.26.16.254
display arp | in 10.26.18.254
display arp | in 10.26.19.254
display arp | in 10.26.20.254
display arp | in 10.26.21.254
display arp | in 10.26.22.254
display arp | in 10.26.23.254
display arp | in 10.26.24.254
display arp | in 10.26.25.254
display arp | in 10.26.17.254
display arp | in 10.26.27.254
display arp | in 10.26.28.254
display arp | in 10.26.29.254
display arp | in 10.26.30.254
display arp | in 10.26.31.254
display arp | in 10.26.39.254
display arp | in 10.26.40.254
display arp | in 10.26.41.254
display arp | in 10.26.42.254
display arp | in 10.26.26.254
display arp | in 10.26.44.254
display arp | in 10.26.46.254
display arp | in 10.26.47.254
display arp | in 10.26.48.254
display arp | in 10.26.49.254
display arp | in 10.26.50.254
display arp | in 10.26.51.254
display arp | in 10.26.52.254
display arp | in 10.26.53.254
display arp | in 10.26.54.254
display arp | in 10.26.55.254
display arp | in 10.26.57.254
display arp | in 10.26.58.254
display arp | in 10.26.59.254
display arp | in 10.26.60.254
display arp | in 10.26.61.254
display arp | in 10.26.62.254
display arp | in 10.26.63.254
display arp | in 10.26.64.254
display arp | in 10.26.65.254
display arp | in 10.26.66.254
display arp | in 10.26.67.254
display arp | in 10.26.68.254
display arp | in 10.26.69.254
display arp | in 10.26.70.254
display arp | in 10.26.71.254
display arp | in 10.26.72.254
display arp | in 10.26.73.254
display arp | in 10.26.74.254
display arp | in 10.26.75.254
display arp | in 10.26.76.254
display arp | in 10.26.77.254
display arp | in 10.26.78.254
display arp | in 10.26.79.254
display arp | in 10.26.80.254
display arp | in 10.26.81.254
display arp | in 10.26.82.254
display arp | in 10.26.83.254
display arp | in 10.26.84.254
display arp | in 10.26.85.254
display arp | in 10.26.86.254
display arp | in 10.26.87.254
display arp | in 10.26.88.254
display arp | in 10.26.89.254
display arp | in 10.26.90.254
display arp | in 10.26.91.254
display arp | in 10.26.92.254
display arp | in 10.26.93.254
display arp | in 10.26.95.254
display arp | in 10.26.96.254
display arp | in 10.26.97.254
display arp | in 10.26.98.254
display arp | in 10.26.100.254
display arp | in 10.26.101.254
display arp | in 10.26.102.254
display arp | in 10.26.103.254
display arp | in 10.26.104.254
display arp | in 10.26.105.254
display arp | in 10.26.106.254
display arp | in 10.26.107.254
display arp | in 10.26.108.254
display arp | in 10.26.109.254
display arp | in 10.26.110.254
display arp | in 10.26.111.254
display arp | in 10.26.112.254
display arp | in 10.26.113.254
display arp | in 10.26.114.254
display arp | in 10.26.115.254
display arp | in 10.26.116.254
display arp | in 10.26.117.254

# OSPF database （AdvRouter is 10.0.0.10）#
display ospf lsdb　# 比較用に全てのDB情報取得

# Vlan が有効になっていること #
dis vlan 3101 to 3710

# SVI status #
# 作業前なので対象VLANの表示無し
dis int brief Vlanif | include 3

# 疎通確認 DC1側 のGW削除作業が完了してる場合、以下は疎通できないが正しい
ping -c 2 10.26.1.254
ping -c 2 10.26.2.254
ping -c 2 10.26.3.254
ping -c 2 10.26.4.254
ping -c 2 10.26.5.254
ping -c 2 10.26.6.254
ping -c 2 10.26.7.254
ping -c 2 10.26.8.254
ping -c 2 10.26.10.254
ping -c 2 10.26.11.254
ping -c 2 10.26.12.254
ping -c 2 10.26.13.254
ping -c 2 10.26.14.254
ping -c 2 10.26.15.254
ping -c 2 10.26.16.254
ping -c 2 10.26.18.254
ping -c 2 10.26.19.254
ping -c 2 10.26.20.254
ping -c 2 10.26.21.254
ping -c 2 10.26.22.254
ping -c 2 10.26.23.254
ping -c 2 10.26.24.254
ping -c 2 10.26.25.254
ping -c 2 10.26.17.254
ping -c 2 10.26.27.254
ping -c 2 10.26.28.254
ping -c 2 10.26.29.254
ping -c 2 10.26.30.254
ping -c 2 10.26.31.254
ping -c 2 10.26.39.254
ping -c 2 10.26.40.254
ping -c 2 10.26.41.254
ping -c 2 10.26.42.254
ping -c 2 10.26.26.254
ping -c 2 10.26.44.254
ping -c 2 10.26.46.254
ping -c 2 10.26.47.254
ping -c 2 10.26.48.254
ping -c 2 10.26.49.254
ping -c 2 10.26.50.254
ping -c 2 10.26.51.254
ping -c 2 10.26.52.254
ping -c 2 10.26.53.254
ping -c 2 10.26.54.254
ping -c 2 10.26.55.254
ping -c 2 10.26.57.254
ping -c 2 10.26.58.254
ping -c 2 10.26.59.254
ping -c 2 10.26.60.254
ping -c 2 10.26.61.254
ping -c 2 10.26.62.254
ping -c 2 10.26.63.254
ping -c 2 10.26.64.254
ping -c 2 10.26.65.254
ping -c 2 10.26.66.254
ping -c 2 10.26.67.254
ping -c 2 10.26.68.254
ping -c 2 10.26.69.254
ping -c 2 10.26.70.254
ping -c 2 10.26.71.254
ping -c 2 10.26.72.254
ping -c 2 10.26.73.254
ping -c 2 10.26.74.254
ping -c 2 10.26.75.254
ping -c 2 10.26.76.254
ping -c 2 10.26.77.254
ping -c 2 10.26.78.254
ping -c 2 10.26.79.254
ping -c 2 10.26.80.254
ping -c 2 10.26.81.254
ping -c 2 10.26.82.254
ping -c 2 10.26.83.254
ping -c 2 10.26.84.254
ping -c 2 10.26.85.254
ping -c 2 10.26.86.254
ping -c 2 10.26.87.254
ping -c 2 10.26.88.254
ping -c 2 10.26.89.254
ping -c 2 10.26.90.254
ping -c 2 10.26.91.254
ping -c 2 10.26.92.254
ping -c 2 10.26.93.254
ping -c 2 10.26.95.254
ping -c 2 10.26.96.254
ping -c 2 10.26.97.254
ping -c 2 10.26.98.254
ping -c 2 10.26.100.254
ping -c 2 10.26.101.254
ping -c 2 10.26.102.254
ping -c 2 10.26.103.254
ping -c 2 10.26.104.254
ping -c 2 10.26.105.254
ping -c 2 10.26.106.254
ping -c 2 10.26.107.254
ping -c 2 10.26.108.254
ping -c 2 10.26.109.254
ping -c 2 10.26.110.254
ping -c 2 10.26.111.254
ping -c 2 10.26.112.254
ping -c 2 10.26.113.254
ping -c 2 10.26.114.254
ping -c 2 10.26.115.254
ping -c 2 10.26.116.254
ping -c 2 10.26.117.254
```
---
#### 設定変更 (DC1 SpineのGWの設定を消す（回線断）の作業が完了していること!)
```rb
sys
#
interface Vlanif3101
 undo shut
interface Vlanif3102
 undo shut
interface Vlanif3103
 undo shut
interface Vlanif3104
 undo shut
interface Vlanif3105
 undo shut
interface Vlanif3106
 undo shut
interface Vlanif3107
 undo shut
interface Vlanif3108
 undo shut
interface Vlanif3110
 undo shut
interface Vlanif3111
 undo shut
interface Vlanif3112
 undo shut
interface Vlanif3113
 undo shut
interface Vlanif3114
 undo shut
interface Vlanif3115
 undo shut
interface Vlanif3116
 undo shut
interface Vlanif3118
 undo shut
interface Vlanif3119
 undo shut
interface Vlanif3120
 undo shut
interface Vlanif3121
 undo shut
interface Vlanif3122
 undo shut
interface Vlanif3123
 undo shut
interface Vlanif3124
 undo shut
interface Vlanif3125
 undo shut
interface Vlanif3117
 undo shut
interface Vlanif3202
 undo shut
interface Vlanif3203
 undo shut
interface Vlanif3204
 undo shut
interface Vlanif3205
 undo shut
interface Vlanif3206
 undo shut
interface Vlanif3207
 undo shut
interface Vlanif3208
 undo shut
interface Vlanif3209
 undo shut
interface Vlanif3210
 undo shut
interface Vlanif3201
 undo shut
interface Vlanif3242
 undo shut
interface Vlanif3244
 undo shut
interface Vlanif3245
 undo shut
interface Vlanif3246
 undo shut
interface Vlanif3247
 undo shut
interface Vlanif3248
 undo shut
interface Vlanif3249
 undo shut
interface Vlanif3250
 undo shut
interface Vlanif3281
 undo shut
interface Vlanif3282
 undo shut
interface Vlanif3283
 undo shut
interface Vlanif3285
 undo shut
interface Vlanif3501
 undo shut
interface Vlanif3502
 undo shut
interface Vlanif3503
 undo shut
interface Vlanif3504
 undo shut
interface Vlanif3505
 undo shut
interface Vlanif3506
 undo shut
interface Vlanif3507
 undo shut
interface Vlanif3508
 undo shut
interface Vlanif3509
 undo shut
interface Vlanif3510
 undo shut
interface Vlanif3541
 undo shut
interface Vlanif3542
 undo shut
interface Vlanif3543
 undo shut
interface Vlanif3544
 undo shut
interface Vlanif3545
 undo shut
interface Vlanif3546
 undo shut
interface Vlanif3547
 undo shut
interface Vlanif3548
 undo shut
interface Vlanif3549
 undo shut
interface Vlanif3550
 undo shut
interface Vlanif3551
 undo shut
interface Vlanif3552
 undo shut
interface Vlanif3553
 undo shut
interface Vlanif3554
 undo shut
interface Vlanif3555
 undo shut
interface Vlanif3556
 undo shut
interface Vlanif3557
 undo shut
interface Vlanif3558
 undo shut
interface Vlanif3559
 undo shut
interface Vlanif3560
 undo shut
interface Vlanif3621
 undo shut
interface Vlanif3622
 undo shut
interface Vlanif3623
 undo shut
interface Vlanif3624
 undo shut
interface Vlanif3625
 undo shut
interface Vlanif3626
 undo shut
interface Vlanif3628
 undo shut
interface Vlanif3629
 undo shut
interface Vlanif3630
 undo shut
interface Vlanif3661
 undo shut
interface Vlanif3663
 undo shut
interface Vlanif3664
 undo shut
interface Vlanif3665
 undo shut
interface Vlanif3666
 undo shut
interface Vlanif3667
 undo shut
interface Vlanif3668
 undo shut
interface Vlanif3669
 undo shut
interface Vlanif3670
 undo shut
interface Vlanif3701
 undo shut
interface Vlanif3702
 undo shut
interface Vlanif3703
 undo shut
interface Vlanif3704
 undo shut
interface Vlanif3705
 undo shut
interface Vlanif3706
 undo shut
interface Vlanif3707
 undo shut
interface Vlanif3708
 undo shut
interface Vlanif3709
 undo shut
interface Vlanif3710
 undo shut
#
quit
#

 # 適用したコンフィグの確認 #
dis con candidate

# Commit #
commit
quit

# Diff #
dis conf cha

# Save #
save 

```      
#### 作業完了後 確認
```rb
# CPU #
dis cpu

# OSPF database #
display ospf lsdb
"事前に取得したDBと比較（作業セグメントのみがDB消えるてること）"


# SVI status （UPしてること）#
dis int brief | in 3


# 疎通確認 
ping -c 2 10.26.1.254
ping -c 2 10.26.2.254
ping -c 2 10.26.3.254
ping -c 2 10.26.4.254
ping -c 2 10.26.5.254
ping -c 2 10.26.6.254
ping -c 2 10.26.7.254
ping -c 2 10.26.8.254
ping -c 2 10.26.10.254
ping -c 2 10.26.11.254
ping -c 2 10.26.12.254
ping -c 2 10.26.13.254
ping -c 2 10.26.14.254
ping -c 2 10.26.15.254
ping -c 2 10.26.16.254
ping -c 2 10.26.18.254
ping -c 2 10.26.19.254
ping -c 2 10.26.20.254
ping -c 2 10.26.21.254
ping -c 2 10.26.22.254
ping -c 2 10.26.23.254
ping -c 2 10.26.24.254
ping -c 2 10.26.25.254
ping -c 2 10.26.17.254
ping -c 2 10.26.27.254
ping -c 2 10.26.28.254
ping -c 2 10.26.29.254
ping -c 2 10.26.30.254
ping -c 2 10.26.31.254
ping -c 2 10.26.39.254
ping -c 2 10.26.40.254
ping -c 2 10.26.41.254
ping -c 2 10.26.42.254
ping -c 2 10.26.26.254
ping -c 2 10.26.44.254
ping -c 2 10.26.46.254
ping -c 2 10.26.47.254
ping -c 2 10.26.48.254
ping -c 2 10.26.49.254
ping -c 2 10.26.50.254
ping -c 2 10.26.51.254
ping -c 2 10.26.52.254
ping -c 2 10.26.53.254
ping -c 2 10.26.54.254
ping -c 2 10.26.55.254
ping -c 2 10.26.57.254
ping -c 2 10.26.58.254
ping -c 2 10.26.59.254
ping -c 2 10.26.60.254
ping -c 2 10.26.61.254
ping -c 2 10.26.62.254
ping -c 2 10.26.63.254
ping -c 2 10.26.64.254
ping -c 2 10.26.65.254
ping -c 2 10.26.66.254
ping -c 2 10.26.67.254
ping -c 2 10.26.68.254
ping -c 2 10.26.69.254
ping -c 2 10.26.70.254
ping -c 2 10.26.71.254
ping -c 2 10.26.72.254
ping -c 2 10.26.73.254
ping -c 2 10.26.74.254
ping -c 2 10.26.75.254
ping -c 2 10.26.76.254
ping -c 2 10.26.77.254
ping -c 2 10.26.78.254
ping -c 2 10.26.79.254
ping -c 2 10.26.80.254
ping -c 2 10.26.81.254
ping -c 2 10.26.82.254
ping -c 2 10.26.83.254
ping -c 2 10.26.84.254
ping -c 2 10.26.85.254
ping -c 2 10.26.86.254
ping -c 2 10.26.87.254
ping -c 2 10.26.88.254
ping -c 2 10.26.89.254
ping -c 2 10.26.90.254
ping -c 2 10.26.91.254
ping -c 2 10.26.92.254
ping -c 2 10.26.93.254
ping -c 2 10.26.95.254
ping -c 2 10.26.96.254
ping -c 2 10.26.97.254
ping -c 2 10.26.98.254
ping -c 2 10.26.100.254
ping -c 2 10.26.101.254
ping -c 2 10.26.102.254
ping -c 2 10.26.103.254
ping -c 2 10.26.104.254
ping -c 2 10.26.105.254
ping -c 2 10.26.106.254
ping -c 2 10.26.107.254
ping -c 2 10.26.108.254
ping -c 2 10.26.109.254
ping -c 2 10.26.110.254
ping -c 2 10.26.111.254
ping -c 2 10.26.112.254
ping -c 2 10.26.113.254
ping -c 2 10.26.114.254
ping -c 2 10.26.115.254
ping -c 2 10.26.116.254
ping -c 2 10.26.117.254

# ARP #
display arp | in 10.26.1.254
display arp | in 10.26.2.254
display arp | in 10.26.3.254
display arp | in 10.26.4.254
display arp | in 10.26.5.254
display arp | in 10.26.6.254
display arp | in 10.26.7.254
display arp | in 10.26.8.254
display arp | in 10.26.10.254
display arp | in 10.26.11.254
display arp | in 10.26.12.254
display arp | in 10.26.13.254
display arp | in 10.26.14.254
display arp | in 10.26.15.254
display arp | in 10.26.16.254
display arp | in 10.26.18.254
display arp | in 10.26.19.254
display arp | in 10.26.20.254
display arp | in 10.26.21.254
display arp | in 10.26.22.254
display arp | in 10.26.23.254
display arp | in 10.26.24.254
display arp | in 10.26.25.254
display arp | in 10.26.17.254
display arp | in 10.26.27.254
display arp | in 10.26.28.254
display arp | in 10.26.29.254
display arp | in 10.26.30.254
display arp | in 10.26.31.254
display arp | in 10.26.39.254
display arp | in 10.26.40.254
display arp | in 10.26.41.254
display arp | in 10.26.42.254
display arp | in 10.26.26.254
display arp | in 10.26.44.254
display arp | in 10.26.46.254
display arp | in 10.26.47.254
display arp | in 10.26.48.254
display arp | in 10.26.49.254
display arp | in 10.26.50.254
display arp | in 10.26.51.254
display arp | in 10.26.52.254
display arp | in 10.26.53.254
display arp | in 10.26.54.254
display arp | in 10.26.55.254
display arp | in 10.26.57.254
display arp | in 10.26.58.254
display arp | in 10.26.59.254
display arp | in 10.26.60.254
display arp | in 10.26.61.254
display arp | in 10.26.62.254
display arp | in 10.26.63.254
display arp | in 10.26.64.254
display arp | in 10.26.65.254
display arp | in 10.26.66.254
display arp | in 10.26.67.254
display arp | in 10.26.68.254
display arp | in 10.26.69.254
display arp | in 10.26.70.254
display arp | in 10.26.71.254
display arp | in 10.26.72.254
display arp | in 10.26.73.254
display arp | in 10.26.74.254
display arp | in 10.26.75.254
display arp | in 10.26.76.254
display arp | in 10.26.77.254
display arp | in 10.26.78.254
display arp | in 10.26.79.254
display arp | in 10.26.80.254
display arp | in 10.26.81.254
display arp | in 10.26.82.254
display arp | in 10.26.83.254
display arp | in 10.26.84.254
display arp | in 10.26.85.254
display arp | in 10.26.86.254
display arp | in 10.26.87.254
display arp | in 10.26.88.254
display arp | in 10.26.89.254
display arp | in 10.26.90.254
display arp | in 10.26.91.254
display arp | in 10.26.92.254
display arp | in 10.26.93.254
display arp | in 10.26.95.254
display arp | in 10.26.96.254
display arp | in 10.26.97.254
display arp | in 10.26.98.254
display arp | in 10.26.100.254
display arp | in 10.26.101.254
display arp | in 10.26.102.254
display arp | in 10.26.103.254
display arp | in 10.26.104.254
display arp | in 10.26.105.254
display arp | in 10.26.106.254
display arp | in 10.26.107.254
display arp | in 10.26.108.254
display arp | in 10.26.109.254
display arp | in 10.26.110.254
display arp | in 10.26.111.254
display arp | in 10.26.112.254
display arp | in 10.26.113.254
display arp | in 10.26.114.254
display arp | in 10.26.115.254
display arp | in 10.26.116.254
display arp | in 10.26.117.254

"22K2039-K2D022-CE8850 のMAC(60de-f3c8-9129) になっていること"
```
---
#### 👼👼👼ロールバック👼👼👼
```rb
# Diff #
display configuration rollback result

# Rollback #
rollback configuration last 1
```      
#### 👼👼👼 Vlanごとに戻す (Vlan番号は適宜変更) 👼👼👼
```rb
# DC6 Spine #
sys

int VlanifXXXX
 shut
quit

dis con can
commit
quit

dis int VlanifXXXX
ping x.x.x.x # 応答が無いこと（正しくIFが無効化できてること）

save

# DC1 Spine 1号機 #
conf t
!
int VlanXXXX
 no shut
end
!
sho int VlanXXXX
sho hsrp group xxxx brief
ping x.x.x.x
sho ip arp x.x.x.x # 自身のMAC（0081.c4f7.227f or 0000.0c9f.fe4e）

copy r s

# DC1 Spine 2号機 #
conf t
!
int VlanXXXX
 no shut
end
!
sho int VlanXXXX
sho hsrp group xxxx brief
ping x.x.x.x
sho ip arp x.x.x.x # 自身のMAC（0081.c4f7.227f or 0000.0c9f.fe4e）

copy r s
```      
