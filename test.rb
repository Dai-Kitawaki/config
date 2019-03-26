------------------
tdc-fw201
------------------
#-----------------------------Modify the link-monitor
config router static
    edit 1
        set dst 101.102.253.5 255.255.255.255
        set device "wan1"
        set dynamic-gateway enable
    next
    edit 2
        set distance 250
        set device "tdc_vpn1"
    next
    edit 3
        set dst 39.110.217.37 255.255.255.255
        set device "wan1"
        set dynamic-gateway enable
    next
    edit 4
        set device "tdc_vpn2"
    next
end
