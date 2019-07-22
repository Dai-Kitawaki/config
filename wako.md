
# 注意など

- ダグラスは含めない
- DC1のglobal IP アドレスが書いてあるのであとで一括で置換する。RNATもあるので注意
- DC6 のglobal addressは133.152.39.16なので置換済だが、かぶるので一時的に別のglobal ip addressを発行 133.152.39.27
- port 2806 2525 2544 2581 2601 2602 444 81 は使っていないので一旦削除したが、A10との差分を最小にするために復活させた
- ACL(いわゆるファイアーウォール)は別途設定する必要がある
- serverにmonitorを設定できないので、serviceGroupでmonitorを設定
  - このときにすでにportが入っているのでTCPのポートを監視するmonitorとした
- nmsg-edge_443 のpoolのmemberのhealth monitorは443 / 80 のtcpとなっている
- F5 で自動的にdownになっているものがあるがここでは無視した
- `bind serviceGroup msg-vserv-2543 nmsg-edge111 2543 -monitorName msg-tcp -monitorName msg-tcp-2580` などとしているが期待通りの動作になるかは不明
- /Common/nmsg-edge_2902 について、本来のmonitorはpoolについているが、serviceGroupにmonitorがつけられないのでserviceにつけた
- LB側gatewayアドレスはA10からpingの届かなかった 10.79.27.253 とした

# 切り替えについて

種別|仮ip|本ip|
--|--|--
global ip|133.152.39.27|133.152.39.16
gateway|10.79.27.253|10.79.27.254

# 設定値参考

- cltTimeoutの300はfastl4 profile のidle-timeoutから
- lbMehodはROUNDROBINなので踏襲。 -backupLBMethodは12.0かららしいが、11.0でも指定できるらしいのでやっとく

# TODO

- その他LBでデフォルトで設定されてる値は？
- profileがあるので追加（まだ作っていないが、完全に再現させようとすると果てしなく大変）

# 参考にした資料

- https://docs.google.com/spreadsheets/d/1CavLHDjlMBHBXKq-hwTetMT6bWsDJDxm92QoIc7uWkM/edit#gid=1080873872

# LBで設定したコマンド（初期構築が主）

```
add ns acl allow-hongo-1 ALLOW -srcIP = 101.102.253.246-101.102.253.247 -priority 170 -kernelstate SFAPPLIED61
add ns acl allow-awsdx ALLOW -srcIP = 10.31.0.0-10.31.255.255 -priority 180 -kernelstate SFAPPLIED61
add ns acl allow-cloud ALLOW -srcIP = 101.102.253.250 -priority 190 -kernelstate SFAPPLIED61
add ns acl allow-office-back ALLOW -srcIP = 192.168.0.0-192.168.255.255 -priority 200 -kernelstate SFAPPLIED61
add ns acl allow-vpn2-back ALLOW -srcIP = 172.29.20.0-172.29.21.255 -priority 210 -kernelstate SFAPPLIED61
add ns acl allow-snmp-01 ALLOW -srcIP = 10.81.8.8-10.81.8.9 -priority 220 -kernelstate SFAPPLIED61
add ns acl allow-dc1-back01 ALLOW -srcIP = 10.16.5.239-10.16.5.240 -destIP = 10.81.8.8-10.81.8.9 -priority 230 -kernelstate SFAPPLIED61
add ns acl allow-sre01 ALLOW -srcIP = 10.26.56.104 -priority 240 -kernelstate SFAPPLIED61
add ns acl allow-sre-jenkins-01 ALLOW -srcIP = 10.26.144.0-10.26.144.255 -priority 250 -kernelstate SFAPPLIED61
add ns acl allow-managed-ssl-01 ALLOW -srcIP = 10.26.17.0-10.26.17.255 -priority 260 -kernelstate SFAPPLIED61
add ns acl allow-lb ALLOW -srcIP = 10.19.27.25-10.19.27.26 -priority 270 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-843-kari ALLOW -destIP = 133.152.39.27 -destPort = 843 -protocol TCP -priority 401 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-2525-2624-kari ALLOW -destIP = 133.152.39.27 -destPort = 2525-2624 -protocol TCP -priority 402 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-2805-2814-kari ALLOW -destIP = 133.152.39.27 -destPort = 2805-2814 -protocol TCP -priority 403 -kernelstate SFAPPLIED61
add ns acl allow-msg-niconare-aws-01-kari ALLOW -srcIP = 54.64.155.159 -destIP = 133.152.39.27 -destPort 2901 TCP -priority 404 -kernelstate SFAPPLIED61
add ns acl allow-msg-niconare-aws-02-kari ALLOW -srcIP = 54.64.242.58 -destIP = 133.152.39.27 -destPort 2901 TCP -priority 405 -kernelstate SFAPPLIED61
add ns acl allow-msg-zane-aws-01-kari ALLOW -srcIP = 52.192.141.142 -destIP = 133.152.39.27 -destPort 2901 TCP -priority 406 -kernelstate SFAPPLIED61
add ns acl allow-msg-zane-aws-02-kari ALLOW -srcIP = 52.69.198.236 -destIP = 133.152.39.27 -destPort 2901 TCP -priority 407 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-81-kari ALLOW -destIP = 133.152.39.27 -destPort = 81 -protocol TCP -priority 409 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-844-kari ALLOW -destIP = 133.152.39.27 -destPort = 844 -protocol TCP -priority 410 -kernelstate SFAPPLIED61
add ns acl allow-situs-monitor-any-01-kari ALLOW -srcIP = 10.0.4.31-10.0.4.32 -destIP = 133.152.39.27 -destPort 2901-2902 -priority 411 -kernelstate SFAPPLIED61
add ns acl allow-situs-monitor-any-02-kari ALLOW -srcIP = 118.21.168.57 -destIP = 133.152.39.27 -destPort 2901-2902 -priority 412 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-80-kari ALLOW -destIP = 133.152.39.27 -destPort = 80 -protocol TCP -priority 413 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-443-kari ALLOW -destIP = 133.152.39.27 -destPort = 443 -protocol TCP -priority 414 -kernelstate SFAPPLIED61
d ns acl allow-msg-niconare-aws-01-kari ALLOW -srcIP = 54.64.155.159 -destIP = 133.152.39.27 -destPort 2901 -protocol TCP -priority 404 -kernelstate SFAPPLIED61
add ns acl allow-msg-niconare-aws-02-kari ALLOW -srcIP = 54.64.242.58 -destIP = 133.152.39.27 -destPort 2901 -protocol TCP -priority 405 -kernelstate SFAPPLIED61
add ns acl allow-msg-zane-aws-01-kari ALLOW -srcIP = 52.192.141.142 -destIP = 133.152.39.27 -destPort 2901 -protocol TCP -priority 406 -kernelstate SFAPPLIED61
add ns acl allow-msg-zane-aws-02-kari ALLOW -srcIP = 52.69.198.236 -destIP = 133.152.39.27 -destPort 2901 -protocol TCP -priority 407 -kernelstate SFAPPLIED61
add ns acl deny-any DENY -priority 70000 -kernelstate SFAPPLIED61
renumber acls
set interface 10/1 -haMonitor OFF -lacpMode ACTIVE -lacpKey 1 -throughput 0 -bandwidthHigh 0 -bandwidthNormal 0 -intftype "Intel 10G" -ifnum LA/1 -lldpmode TRANSCEIVER
set interface 10/3 -haMonitor OFF -lacpMode ACTIVE -lacpKey 1 -throughput 0 -bandwidthHigh 0 -bandwidthNormal 0 -intftype "Intel 10G" -ifnum LA/1 -lldpmode TRANSCEIVER
set channel LA/1 -throughput 0 -lrMinThroughput 0 -bandwidthHigh 0 -bandwidthNormal 0
set ns rpcnode 10.19.27.25 -password nsroot
set ns rpcnode 10.19.27.26 -password nsroot
add ns ip 133.152.39.5 255.255.255.0 -vServer DISABLED -gui DISABLED
```

# VLAN設定

- 参考：https://docs.google.com/spreadsheets/d/1WxOvbSzUo70Q3Bl0oyMrF9UcGZOh6276wmG8C3a0k4Y/edit#gid=0

```
ssh nsroot@10.19.27.25
save ns config
add system user nmsg -timeout 900
add vlan 721 -aliasName nmsg
bind system group Service_operator -userName nmsg
add ns ip 10.79.27.253 -vServer DISABLED -gui DISABLED
bind vlan 721 -ifnum LA/1 -tagged
bind vlan 721 -IPAddress 10.79.27.253 255.255.255.0
set rnat 10.79.27.0 255.255.255.0 -natIP 133.152.39.27
add vlan 2813 -aliasName nmsg-global
bind vlan 2813 -ifnum LA/1 -tagged
bind vlan 2813 -IPAddress 133.152.39.5 255.255.255.0
save ns config
```

# vip設定 
## DC6のIPに置き換える

```
add ns ip 133.152.39.27 255.255.255.255 -type VIP
```

# ノードの追加

```
add server nmsg-edge101 10.79.27.81
add server nmsg-edge102 10.79.27.82
add server nmsg-edge103 10.79.27.83
add server nmsg-edge104 10.79.27.84
add server nmsg-edge105 10.79.27.85
add server nmsg-edge106 10.79.27.86

add server nmsg-edge111 10.79.27.170
add server nmsg-edge112 10.79.27.171
add server nmsg-edge113 10.79.27.172
add server nmsg-edge114 10.79.27.173
add server nmsg-edge115 10.79.27.174
add server nmsg-edge116 10.79.27.175
add server nmsg-edge117 10.79.27.176
add server nmsg-edge118 10.79.27.177
add server nmsg-edge119 10.79.27.178
add server nmsg-edge120 10.79.27.179
add server nmsg-edge121 10.79.27.180
add server nmsg-edge122 10.79.27.181
add server nmsg-edge123 10.79.27.182
add server nmsg-edge124 10.79.27.183
add server nmsg-edge125 10.79.27.184
add server nmsg-edge126 10.79.27.185
add server nmsg-edge127 10.79.27.186
add server nmsg-edge128 10.79.27.187
add server nmsg-edge129 10.79.27.188
add server nmsg-edge130 10.79.27.189
add server nmsg-edge131 10.79.27.190
add server nmsg-edge132 10.79.27.191
add server nmsg-edge133 10.79.27.192
add server nmsg-edge134 10.79.27.193
add server nmsg-edge135 10.79.27.194
add server nmsg-edge136 10.79.27.195
add server nmsg-edge137 10.79.27.196
add server nmsg-edge138 10.79.27.197
add server nmsg-edge139 10.79.27.198
add server nmsg-edge140 10.79.27.199
```

# ノードのdisable

```
disable server nmsg-edge101
disable server nmsg-edge102
disable server nmsg-edge103
disable server nmsg-edge104
disable server nmsg-edge105
disable server nmsg-edge106
```


# グループ作成　17個

```
add serviceGroup msg-vserv-80 tcp -usip YES
add serviceGroup msg-vserv-81 tcp -usip YES
add serviceGroup msg-vserv-443 tcp -usip YES
add serviceGroup msg-vserv-444 tcp -usip YES
add serviceGroup msg-vserv-843 tcp -usip YES
add serviceGroup msg-vserv-2525 tcp -usip YES
add serviceGroup msg-vserv-2543 tcp -usip YES
add serviceGroup msg-vserv-2544 tcp -usip YES
add serviceGroup msg-vserv-2580 tcp -usip YES
add serviceGroup msg-vserv-2581 tcp -usip YES
add serviceGroup msg-vserv-2595 tcp -usip YES
add serviceGroup msg-vserv-2601 tcp -usip YES
add serviceGroup msg-vserv-2602 tcp -usip YES
add serviceGroup msg-vserv-2805 tcp -usip YES
add serviceGroup msg-vserv-2806 tcp -usip YES
add serviceGroup msg-vserv-2901 tcp -usip YES
add serviceGroup msg-vserv-2902 tcp -usip YES
```

# モニター作成

- resptimeoutはintervalより小さくないと設定ができない

```
add lb monitor msg-http-monitor HTTP -respCode 200 -httpRequest "GET /3K7XWyaF.html HTTP/1.1\r\nHost:\r\nConnection: close\r\n\r\n" -LRTM ENABLED -destPort 80 -interval 5 -resptimeout 4 -retries 2 # これ使ってない
add lb monitor msg-tcp TCP -LRTM ENABLED -destPort 0 -interval 5 -resptimeout 4 -retries 2 # この設定でどのtcpでも監視できるはず
add lb monitor msg-tcp-80 TCP -LRTM ENABLED -destPort 80 -interval 5 -resptimeout 4 -retries 2
add lb monitor msg-tcp-443 TCP -LRTM ENABLED -destPort 443 -interval 5 -resptimeout 4 -retries 2
add lb monitor msg-tcp-2543 TCP -LRTM ENABLED -destPort 2543 -interval 5 -resptimeout 4 -retries 2
add lb monitor msg-tcp-2580 TCP -LRTM ENABLED -destPort 2580 -interval 5 -resptimeout 4 -retries 2
add lb monitor msg-tcp-2581 TCP -LRTM ENABLED -destPort 2581 -interval 5 -resptimeout 4 -retries 2
add lb monitor msg-tcp-3902 TCP -LRTM ENABLED -destPort 3902 -interval 5 -resptimeout 4 -retries 2
```

# グループにノードをバインド

```
# /Common/nmsg-edge_80	 101-103 111-140
bind serviceGroup msg-vserv-80 nmsg-edge101 80
bind serviceGroup msg-vserv-80 nmsg-edge102 80
bind serviceGroup msg-vserv-80 nmsg-edge103 80
bind serviceGroup msg-vserv-80 nmsg-edge111 80
bind serviceGroup msg-vserv-80 nmsg-edge112 80
bind serviceGroup msg-vserv-80 nmsg-edge113 80
bind serviceGroup msg-vserv-80 nmsg-edge114 80
bind serviceGroup msg-vserv-80 nmsg-edge115 80
bind serviceGroup msg-vserv-80 nmsg-edge116 80
bind serviceGroup msg-vserv-80 nmsg-edge117 80
bind serviceGroup msg-vserv-80 nmsg-edge118 80
bind serviceGroup msg-vserv-80 nmsg-edge119 80
bind serviceGroup msg-vserv-80 nmsg-edge120 80
bind serviceGroup msg-vserv-80 nmsg-edge121 80
bind serviceGroup msg-vserv-80 nmsg-edge122 80
bind serviceGroup msg-vserv-80 nmsg-edge123 80
bind serviceGroup msg-vserv-80 nmsg-edge124 80
bind serviceGroup msg-vserv-80 nmsg-edge125 80
bind serviceGroup msg-vserv-80 nmsg-edge126 80
bind serviceGroup msg-vserv-80 nmsg-edge127 80
bind serviceGroup msg-vserv-80 nmsg-edge128 80
bind serviceGroup msg-vserv-80 nmsg-edge129 80
bind serviceGroup msg-vserv-80 nmsg-edge130 80
bind serviceGroup msg-vserv-80 nmsg-edge131 80
bind serviceGroup msg-vserv-80 nmsg-edge132 80
bind serviceGroup msg-vserv-80 nmsg-edge133 80
bind serviceGroup msg-vserv-80 nmsg-edge134 80
bind serviceGroup msg-vserv-80 nmsg-edge135 80
bind serviceGroup msg-vserv-80 nmsg-edge136 80
bind serviceGroup msg-vserv-80 nmsg-edge137 80
bind serviceGroup msg-vserv-80 nmsg-edge138 80
bind serviceGroup msg-vserv-80 nmsg-edge139 80
bind serviceGroup msg-vserv-80 nmsg-edge140 80
bind serviceGroup msg-vserv-80 -monitorName msg-tcp

# /Common/nmsg-edge_81 101-106 111-140
bind serviceGroup msg-vserv-81 nmsg-edge101 81
bind serviceGroup msg-vserv-81 nmsg-edge102 81
bind serviceGroup msg-vserv-81 nmsg-edge103 81
bind serviceGroup msg-vserv-81 nmsg-edge104 81
bind serviceGroup msg-vserv-81 nmsg-edge105 81
bind serviceGroup msg-vserv-81 nmsg-edge106 81
bind serviceGroup msg-vserv-81 nmsg-edge111 81
bind serviceGroup msg-vserv-81 nmsg-edge112 81
bind serviceGroup msg-vserv-81 nmsg-edge113 81
bind serviceGroup msg-vserv-81 nmsg-edge114 81
bind serviceGroup msg-vserv-81 nmsg-edge115 81
bind serviceGroup msg-vserv-81 nmsg-edge116 81
bind serviceGroup msg-vserv-81 nmsg-edge117 81
bind serviceGroup msg-vserv-81 nmsg-edge118 81
bind serviceGroup msg-vserv-81 nmsg-edge119 81
bind serviceGroup msg-vserv-81 nmsg-edge120 81
bind serviceGroup msg-vserv-81 nmsg-edge121 81
bind serviceGroup msg-vserv-81 nmsg-edge122 81
bind serviceGroup msg-vserv-81 nmsg-edge123 81
bind serviceGroup msg-vserv-81 nmsg-edge124 81
bind serviceGroup msg-vserv-81 nmsg-edge125 81
bind serviceGroup msg-vserv-81 nmsg-edge126 81
bind serviceGroup msg-vserv-81 nmsg-edge127 81
bind serviceGroup msg-vserv-81 nmsg-edge128 81
bind serviceGroup msg-vserv-81 nmsg-edge129 81
bind serviceGroup msg-vserv-81 nmsg-edge130 81
bind serviceGroup msg-vserv-81 nmsg-edge131 81
bind serviceGroup msg-vserv-81 nmsg-edge132 81
bind serviceGroup msg-vserv-81 nmsg-edge133 81
bind serviceGroup msg-vserv-81 nmsg-edge134 81
bind serviceGroup msg-vserv-81 nmsg-edge135 81
bind serviceGroup msg-vserv-81 nmsg-edge136 81
bind serviceGroup msg-vserv-81 nmsg-edge137 81
bind serviceGroup msg-vserv-81 nmsg-edge138 81
bind serviceGroup msg-vserv-81 nmsg-edge139 81
bind serviceGroup msg-vserv-81 nmsg-edge140 81
bind serviceGroup msg-vserv-81 -monitorName msg-tcp-81

# /Common/nmsg-edge_443	111-140
bind serviceGroup msg-vserv-443 nmsg-edge101 443
bind serviceGroup msg-vserv-443 nmsg-edge102 443
bind serviceGroup msg-vserv-443 nmsg-edge103 443
bind serviceGroup msg-vserv-443 nmsg-edge104 443
bind serviceGroup msg-vserv-443 nmsg-edge105 443
bind serviceGroup msg-vserv-443 nmsg-edge106 443
bind serviceGroup msg-vserv-443 nmsg-edge103 443
bind serviceGroup msg-vserv-443 nmsg-edge111 443
bind serviceGroup msg-vserv-443 nmsg-edge112 443
bind serviceGroup msg-vserv-443 nmsg-edge113 443
bind serviceGroup msg-vserv-443 nmsg-edge114 443
bind serviceGroup msg-vserv-443 nmsg-edge115 443
bind serviceGroup msg-vserv-443 nmsg-edge116 443
bind serviceGroup msg-vserv-443 nmsg-edge117 443
bind serviceGroup msg-vserv-443 nmsg-edge118 443
bind serviceGroup msg-vserv-443 nmsg-edge119 443
bind serviceGroup msg-vserv-443 nmsg-edge120 443
bind serviceGroup msg-vserv-443 nmsg-edge121 443
bind serviceGroup msg-vserv-443 nmsg-edge122 443
bind serviceGroup msg-vserv-443 nmsg-edge123 443
bind serviceGroup msg-vserv-443 nmsg-edge124 443
bind serviceGroup msg-vserv-443 nmsg-edge125 443
bind serviceGroup msg-vserv-443 nmsg-edge126 443
bind serviceGroup msg-vserv-443 nmsg-edge127 443
bind serviceGroup msg-vserv-443 nmsg-edge128 443
bind serviceGroup msg-vserv-443 nmsg-edge129 443
bind serviceGroup msg-vserv-443 nmsg-edge130 443
bind serviceGroup msg-vserv-443 nmsg-edge131 443
bind serviceGroup msg-vserv-443 nmsg-edge132 443
bind serviceGroup msg-vserv-443 nmsg-edge133 443
bind serviceGroup msg-vserv-443 nmsg-edge134 443
bind serviceGroup msg-vserv-443 nmsg-edge135 443
bind serviceGroup msg-vserv-443 nmsg-edge136 443
bind serviceGroup msg-vserv-443 nmsg-edge137 443
bind serviceGroup msg-vserv-443 nmsg-edge138 443
bind serviceGroup msg-vserv-443 nmsg-edge139 443
bind serviceGroup msg-vserv-443 nmsg-edge140 443
bind serviceGroup msg-vserv-443 -monitorName msg-tcp
bind serviceGroup msg-vserv-443 -monitorName msg-tcp-80

# /Common/nmsg-edge_444	101-106 111-140
bind serviceGroup msg-vserv-444 nmsg-edge101 444
bind serviceGroup msg-vserv-444 nmsg-edge102 444
bind serviceGroup msg-vserv-444 nmsg-edge103 444
bind serviceGroup msg-vserv-444 nmsg-edge104 444
bind serviceGroup msg-vserv-444 nmsg-edge105 444
bind serviceGroup msg-vserv-444 nmsg-edge106 444
bind serviceGroup msg-vserv-444 nmsg-edge111 444
bind serviceGroup msg-vserv-444 nmsg-edge112 444
bind serviceGroup msg-vserv-444 nmsg-edge113 444
bind serviceGroup msg-vserv-444 nmsg-edge114 444
bind serviceGroup msg-vserv-444 nmsg-edge115 444
bind serviceGroup msg-vserv-444 nmsg-edge116 444
bind serviceGroup msg-vserv-444 nmsg-edge117 444
bind serviceGroup msg-vserv-444 nmsg-edge118 444
bind serviceGroup msg-vserv-444 nmsg-edge119 444
bind serviceGroup msg-vserv-444 nmsg-edge120 444
bind serviceGroup msg-vserv-444 nmsg-edge121 444
bind serviceGroup msg-vserv-444 nmsg-edge122 444
bind serviceGroup msg-vserv-444 nmsg-edge123 444
bind serviceGroup msg-vserv-444 nmsg-edge124 444
bind serviceGroup msg-vserv-444 nmsg-edge125 444
bind serviceGroup msg-vserv-444 nmsg-edge126 444
bind serviceGroup msg-vserv-444 nmsg-edge127 444
bind serviceGroup msg-vserv-444 nmsg-edge128 444
bind serviceGroup msg-vserv-444 nmsg-edge129 444
bind serviceGroup msg-vserv-444 nmsg-edge130 444
bind serviceGroup msg-vserv-444 nmsg-edge131 444
bind serviceGroup msg-vserv-444 nmsg-edge132 444
bind serviceGroup msg-vserv-444 nmsg-edge133 444
bind serviceGroup msg-vserv-444 nmsg-edge134 444
bind serviceGroup msg-vserv-444 nmsg-edge135 444
bind serviceGroup msg-vserv-444 nmsg-edge136 444
bind serviceGroup msg-vserv-444 nmsg-edge137 444
bind serviceGroup msg-vserv-444 nmsg-edge138 444
bind serviceGroup msg-vserv-444 nmsg-edge139 444
bind serviceGroup msg-vserv-444 nmsg-edge140 444
bind serviceGroup msg-vserv-444 -monitorName msg-tcp
bind serviceGroup msg-vserv-444 -monitorName msg-tcp-81

# /Common/nmsg-edge_843	101-104 111-140
bind serviceGroup msg-vserv-843 nmsg-edge101 843
bind serviceGroup msg-vserv-843 nmsg-edge102 843
bind serviceGroup msg-vserv-843 nmsg-edge103 843
bind serviceGroup msg-vserv-843 nmsg-edge104 843
bind serviceGroup msg-vserv-843 nmsg-edge111 843
bind serviceGroup msg-vserv-843 nmsg-edge112 843
bind serviceGroup msg-vserv-843 nmsg-edge113 843
bind serviceGroup msg-vserv-843 nmsg-edge114 843
bind serviceGroup msg-vserv-843 nmsg-edge115 843
bind serviceGroup msg-vserv-843 nmsg-edge116 843
bind serviceGroup msg-vserv-843 nmsg-edge117 843
bind serviceGroup msg-vserv-843 nmsg-edge118 843
bind serviceGroup msg-vserv-843 nmsg-edge119 843
bind serviceGroup msg-vserv-843 nmsg-edge120 843
bind serviceGroup msg-vserv-843 nmsg-edge121 843
bind serviceGroup msg-vserv-843 nmsg-edge122 843
bind serviceGroup msg-vserv-843 nmsg-edge123 843
bind serviceGroup msg-vserv-843 nmsg-edge124 843
bind serviceGroup msg-vserv-843 nmsg-edge125 843
bind serviceGroup msg-vserv-843 nmsg-edge126 843
bind serviceGroup msg-vserv-843 nmsg-edge127 843
bind serviceGroup msg-vserv-843 nmsg-edge128 843
bind serviceGroup msg-vserv-843 nmsg-edge129 843
bind serviceGroup msg-vserv-843 nmsg-edge130 843
bind serviceGroup msg-vserv-843 nmsg-edge131 843
bind serviceGroup msg-vserv-843 nmsg-edge132 843
bind serviceGroup msg-vserv-843 nmsg-edge133 843
bind serviceGroup msg-vserv-843 nmsg-edge134 843
bind serviceGroup msg-vserv-843 nmsg-edge135 843
bind serviceGroup msg-vserv-843 nmsg-edge136 843
bind serviceGroup msg-vserv-843 nmsg-edge137 843
bind serviceGroup msg-vserv-843 nmsg-edge138 843
bind serviceGroup msg-vserv-843 nmsg-edge139 843
bind serviceGroup msg-vserv-843 nmsg-edge140 843
bind serviceGroup msg-vserv-843 -monitorName msg-tcp

# /Common/nmsg-edge_2525 101-103
bind serviceGroup msg-vserv-2525 nmsg-edge101 2525
bind serviceGroup msg-vserv-2525 nmsg-edge102 2525
bind serviceGroup msg-vserv-2525 nmsg-edge103 2525

# /Common/nmsg-edge_2543 101-106 111-140
bind serviceGroup msg-vserv-2543 nmsg-edge101 2543
bind serviceGroup msg-vserv-2543 nmsg-edge102 2543
bind serviceGroup msg-vserv-2543 nmsg-edge103 2543
bind serviceGroup msg-vserv-2543 nmsg-edge104 2543
bind serviceGroup msg-vserv-2543 nmsg-edge105 2543
bind serviceGroup msg-vserv-2543 nmsg-edge106 2543
bind serviceGroup msg-vserv-2543 nmsg-edge111 2543
bind serviceGroup msg-vserv-2543 nmsg-edge112 2543
bind serviceGroup msg-vserv-2543 nmsg-edge113 2543
bind serviceGroup msg-vserv-2543 nmsg-edge114 2543
bind serviceGroup msg-vserv-2543 nmsg-edge115 2543
bind serviceGroup msg-vserv-2543 nmsg-edge116 2543
bind serviceGroup msg-vserv-2543 nmsg-edge117 2543
bind serviceGroup msg-vserv-2543 nmsg-edge118 2543
bind serviceGroup msg-vserv-2543 nmsg-edge119 2543
bind serviceGroup msg-vserv-2543 nmsg-edge120 2543
bind serviceGroup msg-vserv-2543 nmsg-edge121 2543
bind serviceGroup msg-vserv-2543 nmsg-edge122 2543
bind serviceGroup msg-vserv-2543 nmsg-edge123 2543
bind serviceGroup msg-vserv-2543 nmsg-edge124 2543
bind serviceGroup msg-vserv-2543 nmsg-edge125 2543
bind serviceGroup msg-vserv-2543 nmsg-edge126 2543
bind serviceGroup msg-vserv-2543 nmsg-edge127 2543
bind serviceGroup msg-vserv-2543 nmsg-edge128 2543
bind serviceGroup msg-vserv-2543 nmsg-edge129 2543
bind serviceGroup msg-vserv-2543 nmsg-edge130 2543
bind serviceGroup msg-vserv-2543 nmsg-edge131 2543
bind serviceGroup msg-vserv-2543 nmsg-edge132 2543
bind serviceGroup msg-vserv-2543 nmsg-edge133 2543
bind serviceGroup msg-vserv-2543 nmsg-edge134 2543
bind serviceGroup msg-vserv-2543 nmsg-edge135 2543
bind serviceGroup msg-vserv-2543 nmsg-edge136 2543
bind serviceGroup msg-vserv-2543 nmsg-edge137 2543
bind serviceGroup msg-vserv-2543 nmsg-edge138 2543
bind serviceGroup msg-vserv-2543 nmsg-edge139 2543
bind serviceGroup msg-vserv-2543 nmsg-edge140 2543
bind serviceGroup msg-vserv-2543 -monitorName msg-tcp
bind serviceGroup msg-vserv-2543 -monitorName msg-tcp-2580

# /Common/nmsg-edge_2544 101-106 111-140
bind serviceGroup msg-vserv-2544 nmsg-edge101 2544
bind serviceGroup msg-vserv-2544 nmsg-edge102 2544
bind serviceGroup msg-vserv-2544 nmsg-edge103 2544
bind serviceGroup msg-vserv-2544 nmsg-edge104 2544
bind serviceGroup msg-vserv-2544 nmsg-edge105 2544
bind serviceGroup msg-vserv-2544 nmsg-edge106 2544
bind serviceGroup msg-vserv-2544 nmsg-edge111 2544
bind serviceGroup msg-vserv-2544 nmsg-edge112 2544
bind serviceGroup msg-vserv-2544 nmsg-edge113 2544
bind serviceGroup msg-vserv-2544 nmsg-edge114 2544
bind serviceGroup msg-vserv-2544 nmsg-edge115 2544
bind serviceGroup msg-vserv-2544 nmsg-edge116 2544
bind serviceGroup msg-vserv-2544 nmsg-edge117 2544
bind serviceGroup msg-vserv-2544 nmsg-edge118 2544
bind serviceGroup msg-vserv-2544 nmsg-edge119 2544
bind serviceGroup msg-vserv-2544 nmsg-edge120 2544
bind serviceGroup msg-vserv-2544 nmsg-edge121 2544
bind serviceGroup msg-vserv-2544 nmsg-edge122 2544
bind serviceGroup msg-vserv-2544 nmsg-edge123 2544
bind serviceGroup msg-vserv-2544 nmsg-edge124 2544
bind serviceGroup msg-vserv-2544 nmsg-edge125 2544
bind serviceGroup msg-vserv-2544 nmsg-edge126 2544
bind serviceGroup msg-vserv-2544 nmsg-edge127 2544
bind serviceGroup msg-vserv-2544 nmsg-edge128 2544
bind serviceGroup msg-vserv-2544 nmsg-edge129 2544
bind serviceGroup msg-vserv-2544 nmsg-edge130 2544
bind serviceGroup msg-vserv-2544 nmsg-edge131 2544
bind serviceGroup msg-vserv-2544 nmsg-edge132 2544
bind serviceGroup msg-vserv-2544 nmsg-edge133 2544
bind serviceGroup msg-vserv-2544 nmsg-edge134 2544
bind serviceGroup msg-vserv-2544 nmsg-edge135 2544
bind serviceGroup msg-vserv-2544 nmsg-edge136 2544
bind serviceGroup msg-vserv-2544 nmsg-edge137 2544
bind serviceGroup msg-vserv-2544 nmsg-edge138 2544
bind serviceGroup msg-vserv-2544 nmsg-edge139 2544
bind serviceGroup msg-vserv-2544 nmsg-edge140 2544

# /Common/nmsg-edge_2580 101-106 111-140
bind serviceGroup msg-vserv-2580 nmsg-edge101 2580
bind serviceGroup msg-vserv-2580 nmsg-edge102 2580
bind serviceGroup msg-vserv-2580 nmsg-edge103 2580
bind serviceGroup msg-vserv-2580 nmsg-edge104 2580
bind serviceGroup msg-vserv-2580 nmsg-edge105 2580
bind serviceGroup msg-vserv-2580 nmsg-edge106 2580
bind serviceGroup msg-vserv-2580 nmsg-edge111 2580
bind serviceGroup msg-vserv-2580 nmsg-edge112 2580
bind serviceGroup msg-vserv-2580 nmsg-edge113 2580
bind serviceGroup msg-vserv-2580 nmsg-edge114 2580
bind serviceGroup msg-vserv-2580 nmsg-edge115 2580
bind serviceGroup msg-vserv-2580 nmsg-edge116 2580
bind serviceGroup msg-vserv-2580 nmsg-edge117 2580
bind serviceGroup msg-vserv-2580 nmsg-edge118 2580
bind serviceGroup msg-vserv-2580 nmsg-edge119 2580
bind serviceGroup msg-vserv-2580 nmsg-edge120 2580
bind serviceGroup msg-vserv-2580 nmsg-edge121 2580
bind serviceGroup msg-vserv-2580 nmsg-edge122 2580
bind serviceGroup msg-vserv-2580 nmsg-edge123 2580
bind serviceGroup msg-vserv-2580 nmsg-edge124 2580
bind serviceGroup msg-vserv-2580 nmsg-edge125 2580
bind serviceGroup msg-vserv-2580 nmsg-edge126 2580
bind serviceGroup msg-vserv-2580 nmsg-edge127 2580
bind serviceGroup msg-vserv-2580 nmsg-edge128 2580
bind serviceGroup msg-vserv-2580 nmsg-edge129 2580
bind serviceGroup msg-vserv-2580 nmsg-edge130 2580
bind serviceGroup msg-vserv-2580 nmsg-edge131 2580
bind serviceGroup msg-vserv-2580 nmsg-edge132 2580
bind serviceGroup msg-vserv-2580 nmsg-edge133 2580
bind serviceGroup msg-vserv-2580 nmsg-edge134 2580
bind serviceGroup msg-vserv-2580 nmsg-edge135 2580
bind serviceGroup msg-vserv-2580 nmsg-edge136 2580
bind serviceGroup msg-vserv-2580 nmsg-edge137 2580
bind serviceGroup msg-vserv-2580 nmsg-edge138 2580
bind serviceGroup msg-vserv-2580 nmsg-edge139 2580
bind serviceGroup msg-vserv-2580 nmsg-edge140 2580
bind serviceGroup msg-vserv-2580 -monitorName msg-tcp

# /Common/nmsg-edge_2581 101-106 111-140
bind serviceGroup msg-vserv-2581 nmsg-edge101 2581
bind serviceGroup msg-vserv-2581 nmsg-edge102 2581
bind serviceGroup msg-vserv-2581 nmsg-edge103 2581
bind serviceGroup msg-vserv-2581 nmsg-edge104 2581
bind serviceGroup msg-vserv-2581 nmsg-edge105 2581
bind serviceGroup msg-vserv-2581 nmsg-edge106 2581
bind serviceGroup msg-vserv-2581 nmsg-edge111 2581
bind serviceGroup msg-vserv-2581 nmsg-edge112 2581
bind serviceGroup msg-vserv-2581 nmsg-edge113 2581
bind serviceGroup msg-vserv-2581 nmsg-edge114 2581
bind serviceGroup msg-vserv-2581 nmsg-edge115 2581
bind serviceGroup msg-vserv-2581 nmsg-edge116 2581
bind serviceGroup msg-vserv-2581 nmsg-edge117 2581
bind serviceGroup msg-vserv-2581 nmsg-edge118 2581
bind serviceGroup msg-vserv-2581 nmsg-edge119 2581
bind serviceGroup msg-vserv-2581 nmsg-edge120 2581
bind serviceGroup msg-vserv-2581 nmsg-edge121 2581
bind serviceGroup msg-vserv-2581 nmsg-edge122 2581
bind serviceGroup msg-vserv-2581 nmsg-edge123 2581
bind serviceGroup msg-vserv-2581 nmsg-edge124 2581
bind serviceGroup msg-vserv-2581 nmsg-edge125 2581
bind serviceGroup msg-vserv-2581 nmsg-edge126 2581
bind serviceGroup msg-vserv-2581 nmsg-edge127 2581
bind serviceGroup msg-vserv-2581 nmsg-edge128 2581
bind serviceGroup msg-vserv-2581 nmsg-edge129 2581
bind serviceGroup msg-vserv-2581 nmsg-edge130 2581
bind serviceGroup msg-vserv-2581 nmsg-edge131 2581
bind serviceGroup msg-vserv-2581 nmsg-edge132 2581
bind serviceGroup msg-vserv-2581 nmsg-edge133 2581
bind serviceGroup msg-vserv-2581 nmsg-edge134 2581
bind serviceGroup msg-vserv-2581 nmsg-edge135 2581
bind serviceGroup msg-vserv-2581 nmsg-edge136 2581
bind serviceGroup msg-vserv-2581 nmsg-edge137 2581
bind serviceGroup msg-vserv-2581 nmsg-edge138 2581
bind serviceGroup msg-vserv-2581 nmsg-edge139 2581
bind serviceGroup msg-vserv-2581 nmsg-edge140 2581

# /Common/nmsg-edge_2595 101-106 111-140
bind serviceGroup msg-vserv-2595 nmsg-edge101 2595
bind serviceGroup msg-vserv-2595 nmsg-edge102 2595
bind serviceGroup msg-vserv-2595 nmsg-edge103 2595
bind serviceGroup msg-vserv-2595 nmsg-edge104 2595
bind serviceGroup msg-vserv-2595 nmsg-edge105 2595
bind serviceGroup msg-vserv-2595 nmsg-edge106 2595
bind serviceGroup msg-vserv-2595 nmsg-edge111 2595
bind serviceGroup msg-vserv-2595 nmsg-edge112 2595
bind serviceGroup msg-vserv-2595 nmsg-edge113 2595
bind serviceGroup msg-vserv-2595 nmsg-edge114 2595
bind serviceGroup msg-vserv-2595 nmsg-edge115 2595
bind serviceGroup msg-vserv-2595 nmsg-edge116 2595
bind serviceGroup msg-vserv-2595 nmsg-edge117 2595
bind serviceGroup msg-vserv-2595 nmsg-edge118 2595
bind serviceGroup msg-vserv-2595 nmsg-edge119 2595
bind serviceGroup msg-vserv-2595 nmsg-edge120 2595
bind serviceGroup msg-vserv-2595 nmsg-edge121 2595
bind serviceGroup msg-vserv-2595 nmsg-edge122 2595
bind serviceGroup msg-vserv-2595 nmsg-edge123 2595
bind serviceGroup msg-vserv-2595 nmsg-edge124 2595
bind serviceGroup msg-vserv-2595 nmsg-edge125 2595
bind serviceGroup msg-vserv-2595 nmsg-edge126 2595
bind serviceGroup msg-vserv-2595 nmsg-edge127 2595
bind serviceGroup msg-vserv-2595 nmsg-edge128 2595
bind serviceGroup msg-vserv-2595 nmsg-edge129 2595
bind serviceGroup msg-vserv-2595 nmsg-edge130 2595
bind serviceGroup msg-vserv-2595 nmsg-edge131 2595
bind serviceGroup msg-vserv-2595 nmsg-edge132 2595
bind serviceGroup msg-vserv-2595 nmsg-edge133 2595
bind serviceGroup msg-vserv-2595 nmsg-edge134 2595
bind serviceGroup msg-vserv-2595 nmsg-edge135 2595
bind serviceGroup msg-vserv-2595 nmsg-edge136 2595
bind serviceGroup msg-vserv-2595 nmsg-edge137 2595
bind serviceGroup msg-vserv-2595 nmsg-edge138 2595
bind serviceGroup msg-vserv-2595 nmsg-edge139 2595
bind serviceGroup msg-vserv-2595 nmsg-edge140 2595
bind serviceGroup msg-vserv-2595 -monitorName msg-tcp

# /Common/nmsg-edge_2601 101-103 111-140
bind serviceGroup msg-vserv-2601 nmsg-edge101 2601
bind serviceGroup msg-vserv-2601 nmsg-edge102 2601
bind serviceGroup msg-vserv-2601 nmsg-edge103 2601
bind serviceGroup msg-vserv-2601 nmsg-edge111 2601
bind serviceGroup msg-vserv-2601 nmsg-edge112 2601
bind serviceGroup msg-vserv-2601 nmsg-edge113 2601
bind serviceGroup msg-vserv-2601 nmsg-edge114 2601
bind serviceGroup msg-vserv-2601 nmsg-edge115 2601
bind serviceGroup msg-vserv-2601 nmsg-edge116 2601
bind serviceGroup msg-vserv-2601 nmsg-edge117 2601
bind serviceGroup msg-vserv-2601 nmsg-edge118 2601
bind serviceGroup msg-vserv-2601 nmsg-edge119 2601
bind serviceGroup msg-vserv-2601 nmsg-edge120 2601
bind serviceGroup msg-vserv-2601 nmsg-edge121 2601
bind serviceGroup msg-vserv-2601 nmsg-edge122 2601
bind serviceGroup msg-vserv-2601 nmsg-edge123 2601
bind serviceGroup msg-vserv-2601 nmsg-edge124 2601
bind serviceGroup msg-vserv-2601 nmsg-edge125 2601
bind serviceGroup msg-vserv-2601 nmsg-edge126 2601
bind serviceGroup msg-vserv-2601 nmsg-edge127 2601
bind serviceGroup msg-vserv-2601 nmsg-edge128 2601
bind serviceGroup msg-vserv-2601 nmsg-edge129 2601
bind serviceGroup msg-vserv-2601 nmsg-edge130 2601
bind serviceGroup msg-vserv-2601 nmsg-edge131 2601
bind serviceGroup msg-vserv-2601 nmsg-edge132 2601
bind serviceGroup msg-vserv-2601 nmsg-edge133 2601
bind serviceGroup msg-vserv-2601 nmsg-edge134 2601
bind serviceGroup msg-vserv-2601 nmsg-edge135 2601
bind serviceGroup msg-vserv-2601 nmsg-edge136 2601
bind serviceGroup msg-vserv-2601 nmsg-edge137 2601
bind serviceGroup msg-vserv-2601 nmsg-edge138 2601
bind serviceGroup msg-vserv-2601 nmsg-edge139 2601
bind serviceGroup msg-vserv-2601 nmsg-edge140 2601
bind serviceGroup msg-vserv-2601 -monitorName msg-tcp

# /Common/nmsg-edge_2602 101-103 111-140
bind serviceGroup msg-vserv-2602 nmsg-edge101 2602
bind serviceGroup msg-vserv-2602 nmsg-edge102 2602
bind serviceGroup msg-vserv-2602 nmsg-edge103 2602
bind serviceGroup msg-vserv-2602 nmsg-edge111 2602
bind serviceGroup msg-vserv-2602 nmsg-edge112 2602
bind serviceGroup msg-vserv-2602 nmsg-edge113 2602
bind serviceGroup msg-vserv-2602 nmsg-edge114 2602
bind serviceGroup msg-vserv-2602 nmsg-edge115 2602
bind serviceGroup msg-vserv-2602 nmsg-edge116 2602
bind serviceGroup msg-vserv-2602 nmsg-edge117 2602
bind serviceGroup msg-vserv-2602 nmsg-edge118 2602
bind serviceGroup msg-vserv-2602 nmsg-edge119 2602
bind serviceGroup msg-vserv-2602 nmsg-edge120 2602
bind serviceGroup msg-vserv-2602 nmsg-edge121 2602
bind serviceGroup msg-vserv-2602 nmsg-edge122 2602
bind serviceGroup msg-vserv-2602 nmsg-edge123 2602
bind serviceGroup msg-vserv-2602 nmsg-edge124 2602
bind serviceGroup msg-vserv-2602 nmsg-edge125 2602
bind serviceGroup msg-vserv-2602 nmsg-edge126 2602
bind serviceGroup msg-vserv-2602 nmsg-edge127 2602
bind serviceGroup msg-vserv-2602 nmsg-edge128 2602
bind serviceGroup msg-vserv-2602 nmsg-edge129 2602
bind serviceGroup msg-vserv-2602 nmsg-edge130 2602
bind serviceGroup msg-vserv-2602 nmsg-edge131 2602
bind serviceGroup msg-vserv-2602 nmsg-edge132 2602
bind serviceGroup msg-vserv-2602 nmsg-edge133 2602
bind serviceGroup msg-vserv-2602 nmsg-edge134 2602
bind serviceGroup msg-vserv-2602 nmsg-edge135 2602
bind serviceGroup msg-vserv-2602 nmsg-edge136 2602
bind serviceGroup msg-vserv-2602 nmsg-edge137 2602
bind serviceGroup msg-vserv-2602 nmsg-edge138 2602
bind serviceGroup msg-vserv-2602 nmsg-edge139 2602
bind serviceGroup msg-vserv-2602 nmsg-edge140 2602
bind serviceGroup msg-vserv-2602 -monitorName msg-tcp

# /Common/nmsg-edge_2805 101-103 111-140
bind serviceGroup msg-vserv-2805 nmsg-edge101 2805
bind serviceGroup msg-vserv-2805 nmsg-edge102 2805
bind serviceGroup msg-vserv-2805 nmsg-edge103 2805
bind serviceGroup msg-vserv-2805 nmsg-edge111 2805
bind serviceGroup msg-vserv-2805 nmsg-edge112 2805
bind serviceGroup msg-vserv-2805 nmsg-edge113 2805
bind serviceGroup msg-vserv-2805 nmsg-edge114 2805
bind serviceGroup msg-vserv-2805 nmsg-edge115 2805
bind serviceGroup msg-vserv-2805 nmsg-edge116 2805
bind serviceGroup msg-vserv-2805 nmsg-edge117 2805
bind serviceGroup msg-vserv-2805 nmsg-edge118 2805
bind serviceGroup msg-vserv-2805 nmsg-edge119 2805
bind serviceGroup msg-vserv-2805 nmsg-edge120 2805
bind serviceGroup msg-vserv-2805 nmsg-edge121 2805
bind serviceGroup msg-vserv-2805 nmsg-edge122 2805
bind serviceGroup msg-vserv-2805 nmsg-edge123 2805
bind serviceGroup msg-vserv-2805 nmsg-edge124 2805
bind serviceGroup msg-vserv-2805 nmsg-edge125 2805
bind serviceGroup msg-vserv-2805 nmsg-edge126 2805
bind serviceGroup msg-vserv-2805 nmsg-edge127 2805
bind serviceGroup msg-vserv-2805 nmsg-edge128 2805
bind serviceGroup msg-vserv-2805 nmsg-edge129 2805
bind serviceGroup msg-vserv-2805 nmsg-edge130 2805
bind serviceGroup msg-vserv-2805 nmsg-edge131 2805
bind serviceGroup msg-vserv-2805 nmsg-edge132 2805
bind serviceGroup msg-vserv-2805 nmsg-edge133 2805
bind serviceGroup msg-vserv-2805 nmsg-edge134 2805
bind serviceGroup msg-vserv-2805 nmsg-edge135 2805
bind serviceGroup msg-vserv-2805 nmsg-edge136 2805
bind serviceGroup msg-vserv-2805 nmsg-edge137 2805
bind serviceGroup msg-vserv-2805 nmsg-edge138 2805
bind serviceGroup msg-vserv-2805 nmsg-edge139 2805
bind serviceGroup msg-vserv-2805 nmsg-edge140 2805
bind serviceGroup msg-vserv-2805 -monitorName msg-tcp

# /Common/nmsg-edge_2806 101-103
bind serviceGroup msg-vserv-2806 nmsg-edge101 2806
bind serviceGroup msg-vserv-2806 nmsg-edge102 2806
bind serviceGroup msg-vserv-2806 nmsg-edge103 2806

# /Common/nmsg-edge_2901 101-103 111-140
bind serviceGroup msg-vserv-2901 nmsg-edge101 2901
bind serviceGroup msg-vserv-2901 nmsg-edge102 2901
bind serviceGroup msg-vserv-2901 nmsg-edge103 2901
bind serviceGroup msg-vserv-2901 nmsg-edge111 2901
bind serviceGroup msg-vserv-2901 nmsg-edge112 2901
bind serviceGroup msg-vserv-2901 nmsg-edge113 2901
bind serviceGroup msg-vserv-2901 nmsg-edge114 2901
bind serviceGroup msg-vserv-2901 nmsg-edge115 2901
bind serviceGroup msg-vserv-2901 nmsg-edge116 2901
bind serviceGroup msg-vserv-2901 nmsg-edge117 2901
bind serviceGroup msg-vserv-2901 nmsg-edge118 2901
bind serviceGroup msg-vserv-2901 nmsg-edge119 2901
bind serviceGroup msg-vserv-2901 nmsg-edge120 2901
bind serviceGroup msg-vserv-2901 nmsg-edge121 2901
bind serviceGroup msg-vserv-2901 nmsg-edge122 2901
bind serviceGroup msg-vserv-2901 nmsg-edge123 2901
bind serviceGroup msg-vserv-2901 nmsg-edge124 2901
bind serviceGroup msg-vserv-2901 nmsg-edge125 2901
bind serviceGroup msg-vserv-2901 nmsg-edge126 2901
bind serviceGroup msg-vserv-2901 nmsg-edge127 2901
bind serviceGroup msg-vserv-2901 nmsg-edge128 2901
bind serviceGroup msg-vserv-2901 nmsg-edge129 2901
bind serviceGroup msg-vserv-2901 nmsg-edge130 2901
bind serviceGroup msg-vserv-2901 nmsg-edge131 2901
bind serviceGroup msg-vserv-2901 nmsg-edge132 2901
bind serviceGroup msg-vserv-2901 nmsg-edge133 2901
bind serviceGroup msg-vserv-2901 nmsg-edge134 2901
bind serviceGroup msg-vserv-2901 nmsg-edge135 2901
bind serviceGroup msg-vserv-2901 nmsg-edge136 2901
bind serviceGroup msg-vserv-2901 nmsg-edge137 2901
bind serviceGroup msg-vserv-2901 nmsg-edge138 2901
bind serviceGroup msg-vserv-2901 nmsg-edge139 2901
bind serviceGroup msg-vserv-2901 nmsg-edge140 2901
bind serviceGroup msg-vserv-2901 -monitorName msg-tcp
bind serviceGroup msg-vserv-2901 -monitorName msg-tcp-80

# /Common/nmsg-edge_2902  111-140
bind serviceGroup msg-vserv-2902 nmsg-edge101 2902
bind serviceGroup msg-vserv-2902 nmsg-edge102 2902 # user disabled
bind serviceGroup msg-vserv-2902 nmsg-edge103 2902 # user disabled
bind serviceGroup msg-vserv-2902 nmsg-edge111 2902
bind serviceGroup msg-vserv-2902 nmsg-edge112 2902
bind serviceGroup msg-vserv-2902 nmsg-edge113 2902
bind serviceGroup msg-vserv-2902 nmsg-edge114 2902
bind serviceGroup msg-vserv-2902 nmsg-edge115 2902
bind serviceGroup msg-vserv-2902 nmsg-edge116 2902
bind serviceGroup msg-vserv-2902 nmsg-edge117 2902
bind serviceGroup msg-vserv-2902 nmsg-edge118 2902
bind serviceGroup msg-vserv-2902 nmsg-edge119 2902
bind serviceGroup msg-vserv-2902 nmsg-edge120 2902
bind serviceGroup msg-vserv-2902 nmsg-edge121 2902
bind serviceGroup msg-vserv-2902 nmsg-edge122 2902
bind serviceGroup msg-vserv-2902 nmsg-edge123 2902
bind serviceGroup msg-vserv-2902 nmsg-edge124 2902
bind serviceGroup msg-vserv-2902 nmsg-edge125 2902
bind serviceGroup msg-vserv-2902 nmsg-edge126 2902
bind serviceGroup msg-vserv-2902 nmsg-edge127 2902
bind serviceGroup msg-vserv-2902 nmsg-edge128 2902
bind serviceGroup msg-vserv-2902 nmsg-edge129 2902
bind serviceGroup msg-vserv-2902 nmsg-edge130 2902
bind serviceGroup msg-vserv-2902 nmsg-edge131 2902
bdd lb vserver msg-vserv-80-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTIONind serviceGroup msg-vserv-2902 nmsg-edge132 2902
bind serviceGroup msg-vserv-2902 nmsg-edge133 2902
bind serviceGroup msg-vserv-2902 nmsg-edge134 2902
bind serviceGroup msg-vserv-2902 nmsg-edge135 2902
bind serviceGroup msg-vserv-2902 nmsg-edge136 2902
bind serviceGroup msg-vserv-2902 nmsg-edge137 2902
bind serviceGroup msg-vserv-2902 nmsg-edge138 2902
bind serviceGroup msg-vserv-2902 nmsg-edge139 2902
bind serviceGroup msg-vserv-2902 nmsg-edge140 2902
bind serviceGroup msg-vserv-2902 -monitorName msg-tcp
bind serviceGroup msg-vserv-2902 -monitorName msg-tcp-3902
```

# lb vserver 追加
## optionsは適当

```
add lb vserver msg-vserv-80-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-81-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-443-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-444-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-843-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2525-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2543-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2544-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2580-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2581-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2595-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2601-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2602-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2805-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2806-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2901-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
add lb vserver msg-vserv-2902-vserv TCP 0.0.0.0 0 -persistenceType NONE -cltTimeout 300 -tcpProfileName nstcp_default_profile -downStateFlush disabled -lbMethod ROUNDROBIN -backupLBMethod LEASTCONNECTION
```

```
bind lb vserver msg-vserv-80-vserv msg-vserv-80
bind lb vserver msg-vserv-81-vserv msg-vserv-81
bind lb vserver msg-vserv-443-vserv msg-vserv-443
bind lb vserver msg-vserv-444-vserv msg-vserv-444
bind lb vserver msg-vserv-843-vserv msg-vserv-843
bind lb vserver msg-vserv-2525-vserv msg-vserv-2525
bind lb vserver msg-vserv-2543-vserv msg-vserv-2543
bind lb vserver msg-vserv-2544-vserv msg-vserv-2544
bind lb vserver msg-vserv-2580-vserv msg-vserv-2580
bind lb vserver msg-vserv-2581-vserv msg-vserv-2581
bind lb vserver msg-vserv-2595-vserv msg-vserv-2595
bind lb vserver msg-vserv-2601-vserv msg-vserv-2601
bind lb vserver msg-vserv-2602-vserv msg-vserv-2602
bind lb vserver msg-vserv-2805-vserv msg-vserv-2805
bind lb vserver msg-vserv-2806-vserv msg-vserv-2806
bind lb vserver msg-vserv-2901-vserv msg-vserv-2901
bind lb vserver msg-vserv-2902-vserv msg-vserv-2902
```

# cs vserver追加
## optionsは適当

```
add cs vserver nmsg-edge_80 TCP 133.152.39.27 80 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_443 TCP 133.152.39.27 443 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_444 TCP 133.152.39.27 444 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_843 TCP 133.152.39.27 843 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2525 TCP 133.152.39.27 2525 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2543 TCP 133.152.39.27 2543 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2544 TCP 133.152.39.27 2544 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2580 TCP 133.152.39.27 2580 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2595 TCP 133.152.39.27 2595 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2601 TCP 133.152.39.27 2601 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2602 TCP 133.152.39.27 2602 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2805 TCP 133.152.39.27 2805 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2806 TCP 133.152.39.27 2806 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2901 TCP 133.152.39.27 2901 -cltTimeout 300 -tcpProfileName nstcp_default_profile
add cs vserver nmsg-edge_2902 TCP 133.152.39.27 2902 -cltTimeout 300 -tcpProfileName nstcp_default_profile
```

## cs serverにlbvserverをバインド
```
bind cs vserver nmsg-edge_80    -lbvserver msg-vserv-80-vserv
bind cs vserver nmsg-edge_81    -lbvserver msg-vserv-81-vserv
bind cs vserver nmsg-edge_443   -lbvserver msg-vserv-443-vserv
bind cs vserver nmsg-edge_444   -lbvserver msg-vserv-444-vserv
bind cs vserver nmsg-edge_843   -lbvserver msg-vserv-843-vserv
bind cs vserver nmsg-edge_2525  -lbvserver msg-vserv-2525-vserv
bind cs vserver nmsg-edge_2544  -lbvserver msg-vserv-2544-vserv
bind cs vserver nmsg-edge_2580  -lbvserver msg-vserv-2580-vserv
bind cs vserver nmsg-edge_2581  -lbvserver msg-vserv-2581-vserv
bind cs vserver nmsg-edge_2595  -lbvserver msg-vserv-2595-vserv
bind cs vserver nmsg-edge_2601  -lbvserver msg-vserv-2601-vserv
bind cs vserver nmsg-edge_2602  -lbvserver msg-vserv-2602-vserv
bind cs vserver nmsg-edge_2805  -lbvserver msg-vserv-2805-vserv
bind cs vserver nmsg-edge_2806  -lbvserver msg-vserv-2806-vserv
bind cs vserver nmsg-edge_2901  -lbvserver msg-vserv-2901-vserv
bind cs vserver nmsg-edge_2902  -lbvserver msg-vserv-2902-vserv
```


# NAT

```
## 10.79.27.81-10.79.27.199 は 133.152.39.27で出ていく
add ns acl allow-msg-prod ALLOW -srcIP = 10.79.27.81-10.79.27.199 -priority 10 -kernelstate SFAPPLIED61
set rnat allow-msg-prod -natIP 133.152.39.27

## 10.79.27.47 は 133.152.39.27で出ていく
add ns acl allow-msg-cm-prod ALLOW -srcIP = 10.79.27.47 -priority 10 -kernelstate SFAPPLIED61
set rnat allow-msg-cm-prod -natIP 133.152.39.27

## 10.79.27.41/32は 133.152.39.27で出ていく
add ns acl allow-msg-zabbix-prod ALLOW -srcIP = 10.79.27.41 -priority 10 -kernelstate SFAPPLIED61
set rnat allow-msg-zabbix-prod -natIP 133.152.39.27
```

# ACL

- 参考 https://docs.google.com/spreadsheets/d/1_zQ_be21QJ6SHQEyshDHA6u0-VMXMUSwjdk_OlgM_Vk/edit#gid=0

```

# shimesaba any
add ns acl allow-msg-prod-any-843 ALLOW -destIP = 133.152.39.16 -destPort = 843 -protocol TCP -priority 300 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-2525-2624 ALLOW -destIP = 133.152.39.16 -destPort = 2525-2624 -protocol TCP -priority 302 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-2805-2814 ALLOW -destIP = 133.152.39.16 -destPort = 2805-2814 -protocol TCP -priority 304 -kernelstate SFAPPLIED61
add ns acl allow-msg-niconare-aws-01 ALLOW -srcIP = 54.64.155.159 -destIP = 133.152.39.16 -destPort 2901 -protocol TCP -priority 305 -kernelstate SFAPPLIED61
add ns acl allow-msg-niconare-aws-02 ALLOW -srcIP = 54.64.242.58 -destIP = 133.152.39.16 -destPort 2901 -protocol TCP -priority 306 -kernelstate SFAPPLIED61
add ns acl allow-msg-zane-aws-01 ALLOW -srcIP = 52.192.141.142 -destIP = 133.152.39.16 -destPort 2901 -protocol TCP -priority 307 -kernelstate SFAPPLIED61
add ns acl allow-msg-zane-aws-02 ALLOW -srcIP = 52.69.198.236 -destIP = 133.152.39.16 -destPort 2901 -protocol TCP -priority 308 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-81 ALLOW -destIP = 133.152.39.16 -destPort = 81 -protocol TCP -priority 310 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-844 ALLOW -destIP = 133.152.39.16 -destPort = 844 -protocol TCP -priority 311 -kernelstate SFAPPLIED61
add ns acl allow-situs-monitor-any-01 ALLOW -srcIP = 10.0.4.31-10.0.4.32 -destIP = 133.152.39.16 -destPort 2901-2902 -priority 312 -kernelstate SFAPPLIED61
add ns acl allow-situs-monitor-any-02 ALLOW -srcIP = 118.21.168.57 -destIP = 133.152.39.16 -destPort 2901-2902 -priority 313 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-80 ALLOW -destIP = 133.152.39.16 -destPort = 80 -protocol TCP -priority 314 -kernelstate SFAPPLIED61
add ns acl allow-msg-prod-any-443 ALLOW -destIP = 133.152.39.16 -destPort = 443 -protocol TCP -priority 315 -kernelstate SFAPPLIED61

add ns acl deny-any DENY -priority 70000 -kernelstate SFAPPLIED61

renumber acls
apply acls
```

# interface up

```
enable interface 10/1
enable interface 10/3
```

# save 

```
save ns config
```


