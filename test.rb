#全ての設定変更完了後に 有効 にする
#-----------------------------Modify the link-monitor
config system link-monitor
    edit "WAN1"
    set status disable
        set server "113.43.192.169"
    next
end
 
#-----------------------------Modify the service
config firewall service custom
    edit "port_8081"
        set tcp-portrange 8081
        set udp-portrange 8081
    next
    edit "port_8281"
        set tcp-portrange 8281
        set udp-portrange 8281
    next
    edit "port_9000"
        set tcp-portrange 9000
        set udp-portrange 9000
    next
    edit "port_9001"
        set tcp-portrange 9001
        set udp-portrange 9001
    next   
end
 
#-----------------------------Modify the SG
config firewall service group
    edit "SG_TVU_01"
        set member "port_8080" "port_8280"
    next
    edit "SG_TVU_02"
        set member "port_8081" "port_8281"
    next
    edit "SG_LiveU_01"
        set member "port_9000"
    next
    edit "SG_LiveU_02"
        set member "port_9001"
    next
end
 
#-----------------------------Modify the VIP
config firewall vip
#--------------------------------------------TVU01
    edit "vip_TVU_01_tcp8080"
        set extip 113.43.192.170
        set extintf "any"
        set portforward enable
        set mappedip "172.25.5.205"
        set protocol tcp
        set extport 8080
        set mappedport 8080
    next
    edit "vip_TVU_01_udp8080"
        set extip 113.43.192.170
        set extintf "any"
        set portforward enable
        set mappedip "172.25.5.205"
        set protocol udp
        set extport 8080
        set mappedport 8080
    next
#-------------------------------------------------TVU02
    edit "vip_TVU_02_tcp8280"
        set extip 113.43.192.170
        set extintf "any"
        set portforward enable
        set mappedip "172.25.5.206"
        set protocol tcp
        set extport 8280
        set mappedport 8280
    next
    edit "vip_TVU_02_udp8280"
        set extip 113.43.192.170
        set extintf "any"
        set portforward enable
        set mappedip "172.25.5.206"
        set protocol udp
        set extport 8280
        set mappedport 8280
    next
#--------------------------------------------LiveU01
   edit "vip_LiveU_01_tcp9000"
       set extip 113.43.192.170
       set extintf "any"
       set portforward enable
       set mappedip "172.25.5.205"
       set protocol tcp
       set extport 9000
       set mappedport 9000
   next
   edit "vip_LiveU_01_udp9000"
       set extip 113.43.192.170
       set extintf "any"
       set portforward enable
       set mappedip "172.25.5.205"
       set protocol udp
       set extport 9000
       set mappedport 9000
   next
#-------------------------------------------------LiveU02
   edit "vip_LiveU_02_tcp9001"
       set extip 113.43.192.170
       set extintf "any"
       set portforward enable
       set mappedip "172.25.5.206"
       set protocol tcp
       set extport 9001
       set mappedport 9001
   next
   edit "vip_LiveU_02_udp9001"
       set extip 113.43.192.170
       set extintf "any"
       set portforward enable
       set mappedip "172.25.5.206"
       set protocol udp
       set extport 9001
       set mappedport 9001
   next
end
 
#-----------------------------Modify the policy
config firewall policy
    edit 18
        unset poolname
        unset ippool
    next
    edit 19
        unset poolname
        unset ippool
    next
    edit 21
        unset poolname
        unset ippool
    next
 
    edit 23
        set dstaddr "vip_TVU_01_tcp8080" "vip_TVU_01_udp8080" "vip_LiveU_01_tcp9000" "vip_LiveU_01_udp9000"
        set service "SG_TVU_01" "SG_LiveU_01"
    next
    edit 24
        set dstaddr "vip_TVU_02_tcp8280" "vip_TVU_02_udp8280" "vip_LiveU_02_tcp9001" "vip_LiveU_02_udp9001"
        set service "SG_TVU_02" "SG_LiveU_02"
    next
end
 
#-----------------------------Modify the route
config router static
    edit 1
        set gateway 113.43.192.169
    next
    edit 11
        set gateway 113.43.192.169
    next
end
 
#-----------------------------Modify the PBR
config router policy
    edit 17
        set gateway 113.43.192.169
    next
    edit 10
        set gateway 113.43.192.169
    next
    edit 13
        set gateway 113.43.192.169
    next
    edit 15
        set gateway 113.43.192.169
    next
end
 
#-----------------------------Modify the link-monitor
config system link-monitor
    edit "WAN1"
    set status enable
    next
end
