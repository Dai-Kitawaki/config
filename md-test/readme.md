## NET-2726_配信ブロック増速手順作成_QFX51VC
1- 設定変更  
2- モジュールを挿す  

-----------------

### [QFX51VC-B1 / コンソールサーバー ](https://docs.google.com/spreadsheets/d/1b3y44zG8fqMLKzecoCpmpUxvp5d1A0eVsMhXfsREq8A/edit#gid=1167760439&range=I153)  
#### 設定変更
```rb
cli
configure

delete interfaces et-0/0/19 unit 0 family ethernet-switching storm-control default
delete interfaces xe-0/0/19:0 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:1 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:2 unit 0 family ethernet-switching vlan members DBLOCK1
set interfaces et-0/0/19 ether-options 802.3ad ae1

show | compare
commit check synchronize
commit synchronize
```

### [QFX51VC-B2 / コンソールサーバー ](https://docs.google.com/spreadsheets/d/1b3y44zG8fqMLKzecoCpmpUxvp5d1A0eVsMhXfsREq8A/edit#gid=1167760439&range=I153)  
#### 設定変更
```rb
cli
configure

delete interfaces et-0/0/19 unit 0 family ethernet-switching storm-control default
delete interfaces xe-0/0/19:0 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:1 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:2 unit 0 family ethernet-switching vlan members DBLOCK1
set interfaces et-0/0/19 ether-options 802.3ad ae1

show | compare
commit check synchronize
commit synchronize
```

### [QFX51VC-B3 / コンソールサーバー ](https://docs.google.com/spreadsheets/d/1b3y44zG8fqMLKzecoCpmpUxvp5d1A0eVsMhXfsREq8A/edit#gid=1167760439&range=I153)  
#### 設定変更
```rb
cli
configure

delete interfaces et-0/0/19 unit 0 family ethernet-switching storm-control default
delete interfaces xe-0/0/19:0 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:1 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:2 unit 0 family ethernet-switching vlan members DBLOCK1
set interfaces et-0/0/19 ether-options 802.3ad ae1

show | compare
commit check synchronize
commit synchronize
```

### [QFX51VC-B4 / コンソールサーバー ](https://docs.google.com/spreadsheets/d/1b3y44zG8fqMLKzecoCpmpUxvp5d1A0eVsMhXfsREq8A/edit#gid=1167760439&range=I154)  
#### 設定変更
```rb
cli
configure

delete interfaces et-0/0/19 unit 0 family ethernet-switching storm-control default
delete interfaces xe-0/0/19:0 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:1 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:2 unit 0 family ethernet-switching vlan members DBLOCK1
set interfaces et-0/0/19 ether-options 802.3ad ae1

show | compare
commit check synchronize
commit synchronize
```

### [QFX51VC-B5 / コンソールサーバー ](https://docs.google.com/spreadsheets/d/1b3y44zG8fqMLKzecoCpmpUxvp5d1A0eVsMhXfsREq8A/edit#gid=1167760439&range=I154)  
#### 設定変更
```rb
cli
configure

delete interfaces et-0/0/19 unit 0 family ethernet-switching storm-control default
delete interfaces xe-0/0/19:0 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:1 unit 0 family ethernet-switching vlan members DBLOCK1
delete interfaces xe-0/0/19:2 unit 0 family ethernet-switching vlan members DBLOCK1
set interfaces et-0/0/19 ether-options 802.3ad ae1

show | compare
commit check synchronize
commit synchronize
```
