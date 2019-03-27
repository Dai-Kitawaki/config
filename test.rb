#####################################
# 保険用 SSH 接続設定
#####################################

# fjt-fw201
config router static
    #                                               DC okb-vpn-global
    edit 98
        set dst 101.102.253.101 255.255.255.255
        set gateway 10.32.16.1
        set device "wan1"
    next
    #                                               歌舞伎座 intra-global
    edit 99
    set dst 101.110.31.120 255.255.255.255
        set gateway 10.32.16.1
        set device "wan1"
    next
end
 
# vtn-fw901
config router static
    #                                               DC okb-vpn-global
    edit 98
        set dst 101.102.253.101 255.255.255.255
        set gateway 203.174.79.65
        set device "wan1"
    next
    #                                               歌舞伎座 intra-global
    edit 99
        set dst 101.110.31.120 255.255.255.255
        set gateway 203.174.79.65
        set device "wan1"
    next
end

# tdc-fw201
config router static
    #                                               DC okb-vpn-global
    edit 98
        set dst 101.102.253.101 255.255.255.255
        set gateway 59.146.160.120
        set device "wan1"
    next
    #                                               歌舞伎座 intra-global
    edit 99
        set dst 101.110.31.120 255.255.255.255
        set gateway 59.146.160.120
        set device "wan1"
    next
end

 
# 歌舞伎座 情シスセグ / VPN経由(okb)から以下のグローバルIPへ直接通信できること
vtnグローバルIP：203.174.79.117
fjtグローバルIP：113.43.83.58
tdcグローバルIP：59.146.160.120


====================================
tdc-fw201
====================================
#----------Check
get router info routing-table all
get ipsec tunnel list


#-----------------------------Modify the route
config router static
    edit 4
        set distance 251
    next
end


#----------Check デフォルトゲートウェイがvpn1に向いてること
get router info routing-table all
get ipsec tunnel list



====================================
vtn-fw901
====================================
#----------Check
get router info routing-table all
get ipsec tunnel list


#-----------------------------Modify the route
config router static
    edit 2
        set distance 250
    next
    edit 4
        set distance 251
    next
end


#----------Check デフォルトゲートウェイがvpn1に向いてること
get router info routing-table all
get ipsec tunnel list


====================================
fjt-fw201
====================================
#----------Check
get router info routing-table all
get ipsec tunnel list


#-----------------------------Modify the route
config router static
    edit 2
        set distance 250
    next
    edit 4
        set distance 251
    next
end


#----------Check デフォルトゲートウェイがvpn1に向いてること
get router info routing-table all
get ipsec tunnel list


====================================
okb-vpngw101
====================================
#----------Check 
get router info routing-table all | grep vpn
get ipsec tunnel list | grep up

#-----------------------------Modify the route
config router static
    edit 304
        set distance 251
    next
    edit 403
        set distance 250
    next
    edit 404
        set distance 251
    next
    edit 503
        set distance 250
    next
    edit 504
        set distance 251
    next
end

#----------Check  デフォルトゲートウェイがvpn1に向いてること
get router info routing-table all | grep vpn
get ipsec tunnel list | grep up

#####################################
# 保険用 SSH 接続設定 削除
#####################################
# fjt-fw201 / vtn-fw901 / tdc-fw201 共通コンフィグ

config router static
    delete 98
    delete 99
end
