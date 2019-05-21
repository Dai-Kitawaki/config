## タイトル
ベアメタル用リーフスイッチ構築
## チケット
https://atl.dwango.co.jp/jira/browse/NET-2678
## 概要
## 作業対象と概要
DC1->DC6移行のためベアメタル用リーフスイッチの構築
1. bare-metal　管理用リーフスイッチにbare-metal用leaf 管理vlan を割り当てる
2. bare-metal用leaf スイッチにnico spineとlagをprivate, global用の合計2本)組み
   global用 port-channelにvlan2801-2900(global valn)を渡す
3. nico spine スイッチにbare-metal向けにprivate, globalの2本のlagを組み
   global用ポートチャネルにvlan 2801-2900を渡す。

ベアメタルリーフスイッチ、ベアメタル管理用リーフスイッチは管理IP、stackなどの初期設定済みのはず

### ネットワーク構成
https://atl.dwango.co.jp/confluence/pages/viewpage.action?pageId=171423740

nico spine === baremetal leaf ---- baermetal-management-leaf

## 設定手順
### ベアメタル管理スイッチ
#### 作業対象
K2D263	23K0595		10.81.0.123

#### 事前確認
```
dis logbuffer              # errorとかwarnがないことを確認
dis cpu                    # cpuが張り付いてないことを確認
dis configuration changes  # diffないことを確認

# 現在の設定を確認する。
display cu | no-more

# ここは設定内容に応じて実施する。
display vlan 1000
display cu interface GigabitEthernet0/0/47
display cu interface GigabitEthernet0/0/48
#
```
#### 設定変更
```

sys

interface GigabitEthernet0/0/47
 port link-type access
 port default vlan 1000
interface GigabitEthernet0/0/48
 port link-type access
 port default vlan 1000

dis con can
dis con can merge
# 問題なければ
commit
``` 
##### 事後確認
``` 
dis logbuffer              # errorとかwarnがないことを確認
dis cpu                    # cpuが張り付いてないことを確認
dis mem
#
# 差分を確認する。
display cu | no-more

# 設定内容によって変更する。
display cu interface Eth-Trunk 11　#該当インターフェイスへ設定追加を確認
display cu interface Eth-Trunk 12　#該当インターフェイスへ設定追加を確認
display cu
display vlan 3951　#VID3951へ該当Portsの追加を確認
#
# 問題なければ保存する。
save
#保存ファイルと変更がないことを確認する。
dis con cha
``` 

#### 問題があった場合の切り戻し方法
``` 
# diffを確認
display configuration rollback result

# 切戻実施
rollback configuration last 1

commit
save
``` 

### ベアメタル用リーフスイッチ
#### 作業対象
ベアメタルリーフ
K2D263	23K0559		10.81.0.120
#### 事前確認
```
dis logbuffer              # errorとかwarnがないことを確認
dis cpu                    # cpuが張り付いてないことを確認
dis configuration changes  # diffないことを確認

# 現在の設定を確認する。
display cu | no-more

# ここは設定内容に応じて実施する。
display vlan 
display ether-trunk 27
display ether-trunk 28
dis cur interface 100GE1/0/27
dis cur interface 100GE1/0/28
dis cur interface 100GE2/0/27
dis cur interface 100GE2/0/28

#
```
#### 設定変更
```
sys

####
#
vlan batch 2801-2900
#
interface MEth0/0/0
 ip binding vpn-instance management
 ip address 10.81.0.120 255.255.255.0
#
interface Eth-Trunk 27
 description to_nico_spine-Private
 port link-type trunk
 undo port trunk allow-pass vlan 1
 mode lacp-static
interface Eth-Trunk 28
 description to_nico_spine-global
 port link-type trunk
 undo port trunk allow-pass vlan 1
 port trunk allow-pass vlan 2801 to 2900
 mode lacp-static
#
interface 100GE1/0/27
 eth-trunk 27
interface 100GE1/0/28
 eth-trunk 28
interface 100GE2/0/27
 eth-trunk 27
interface 100GE2/0/28
 eth-trunk 28
#

dis logbuffer              # errorとかwarnがないことを確認
dis cpu                    # cpuが張り付いてないことを確認
dis mem
#
# 差分を確認する。
display cu | no-more
dis con can
dis con can merge
# 問題なければ
commit
```

##### 事後確認
``` 
# vlanを確認する
display vlan

display eth-trunk 27
display eth-trunk 28
# 該当インターフェイスに設定が入っていることを確認する。
display cu interface Eth-Trunk 27　
display cu interface Eth-Trunk 28
dis cu inter interface 100ge1/0/27
dis cu inter interface 100ge1/0/28
dis cu inter interface 100ge2/0/27
dis cu inter interface 100ge2/0/27

#
# 問題なければ保存する。
save
#保存ファイルと変更がないことを確認する。
dis con cha
``` 
#### 問題があった場合の切り戻し方法
``` 
# diffを確認
display configuration rollback result

# 切戻実施
rollback configuration last 1

commit
save
``` 

### nicho sphere spine switch
#### 作業対象
``` 
nico sphere spine switch
22K2039-K2D022-CE8850
22K2037-K2D022-CE8850
10.81.0.13
``` 

#### 事前確認
```
dis logbuffer              # errorとかwarnがないことを確認
dis cpu                    # cpuが張り付いてないことを確認
dis configuration changes  # diffないことを確認

# 現在の設定を確認する。
display cu | no-more

# ここは設定内容に応じて実施する。
display ether-trunk 31
display ether-trunk 32
# shutdownされているはず
display cur inter 100ge 1/0/16
display cur inter 100ge 1/0/19
display cur inter 100ge 2/0/16
display cur inter 100ge 2/0/19

#
```
#### 設定変更
```
sys
interface Eth-Trunk 31
 description to_baremetal-leaf-Private
 port link-type trunk
 undo port trunk allow-pass vlan 1
 mode lacp-static
interface Eth-Trunk 32
 description to_bametal-leaf-global
 port link-type trunk
 undo port trunk allow-pass vlan 1
 port trunk allow-pass vlan 2801 to 2900
 mode lacp-static
interface 100GE1/0/16
# 配線されていたら undo shutする
# undo shutdown
 eth-trunk 31
interface 100GE1/0/19
# 配線されていたら undo shutする
# undo shutdown
 eth-trunk 32
interface 100GE2/0/16
# 配線されていたら undo shutする
# undo shutdown
 eth-trunk 31
interface 100GE2/0/19
# 配線されていたら undo shutする
# undo shutdown
 eth-trunk 32
# 差分を確認する。
display cu | no-more
dis con can
dis con can merge
# 問題なければ
commit
``` 
##### 事後確認
``` 
# 現在の設定を確認する。
display cu | no-more

# vlanを確認する
display vlan

#該当インターフェイスへ設定追加を確認
display ether-trunk 31
display ether-trunk 32
dis cu inter interface 100ge1/0/16
dis cu inter interface 100ge1/0/19
dis cu inter interface 100ge2/0/16
dis cu inter interface 100ge2/0/19
#
# 問題なければ保存する。
save
#保存ファイルと変更がないことを確認する。
dis con cha
``` 

#### 問題があった場合の切り戻し方法
``` 
# diffを確認
display configuration rollback result

# 切戻実施
rollback configuration last 1

commit
save
``` 
