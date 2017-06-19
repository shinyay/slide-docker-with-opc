% コンテナ技術/CCS/ACCS <br> ![](images/cloudgs_occs.png)![](images/moby_large.png)![](images/cloudgs_appcontainer.png)
% Shinya Yanagihara
% June-21-2017

# コンテナ技術 <br>![](images/moby_large.png)


---

### コンテナ型仮想化

![](images/vm-container.png)

---

### ファイルシステムの差分管理

![](images/container-layers-cas.png)

---

### コンテナ技術の歴史

|#|Year|Name|
|--|--|--|
|1|1979|choot|
|2|2000|FreeBSD Jail|
|3|2005|Solaris Containers|
|4|2008|LXC|
|5|2014|Docker|

---

### chroot

ルートディレクトリを変更するシステムコール

![](images/chroot.png)

---

### FreeBSD Jail

chroot を拡張し、ファイルシステムの名前空間以外も隔離
- プロセスリスト
- ネットワークスタック
ユースケース：root 権限の一般ユーザへの委譲

---

### Solaris Containers

![](images/zone.gif)


---

### LXC (Linux Containers)

単一の Linux カーネルをプロセス毎に隔離し、複数の仮想サーバを制御する仮想環境

- namespaces (カーネルの名前空間)
- cgroups (コントロールグループ )

<div style="text-align:center;">
  <img src="images/docker-isolation.png" style="width:50%;"/>
</div>


---

#### namespaces

|名前空間|隔離対象|
|---|---|
|Mount|ファイルシステム|
|UTS|ホスト名, NIS ドメイン名|
|IPC|プロセス間通信, POSIX メッセージキュー|
|PID|プロセスID, コンテナが違えば同一 ID 可|
|Network|ネットワークデバイス, IP アドレス, IP テーブル等|
|User|ユーザ (uid), グループ (group)|

---

#### cgroups

|サブシステム|機能概要|
|---|---|
|cpu|CPUのスケジューリングを制御<br>相対配分: CPU時間の割当を割合で指定<br>帯域制御: タスクが実行できる合計時間を制限|
|cpuacct|グループ内のタスクが消費するCPU時間をレポート|
|cpuset|グループへのCPU，メモリノードの割り当て|
|memory|グループ内のタスクが消費するメモリリソースのレポートと制限|
|blkio|ブロックデバイスに対する制限<br>重みづけ配分: I/Oアクセスの比率を割合で指定<br>帯域制限: 各デバイスに対して行える操作数の制限|
|devices|グループ内のタスクのデバイスへのアクセスの許可，禁止の指定|
|net_cls|グループ内のプロセスが発信するパケットの制御|
|net_prio|グループ内のタスクのネットワークの優先度の制御|
|freezer|	グループ内のプロセス全てを同時に一時停止・再開|

---

### Docker

- Docker <= 0.8 は LXC (や libvirt, systemd-nspawn) 経由で名前空間, cgroups 等を利用
- Docker >= 0.9 は libcontainer ドライバ経由でカーネルのコンテナAPIを直接コールするため、LXCがなくても稼働可能

**Docker Engine** で制御

<div style="text-align:center;">
  <img src="images/docker-engine.png" style="width:50%;"/>
</div>


---

#### Docker Engine アーキテクチャ

![](images/runc-containerd.png)

---

#### runC

- Docker のコアコンテナランタイム
- Docker >= 1.11 は、OCI 準拠の構成となり、Docker Engine っが **containerd** と通信し、containerd はランタイムとして、**runC** をす使用する

##### Open Containers Initiative
- ![](images/oci.png) コンテナの標準仕様を議論・策定する標準化団体

##### runC
- オープン・コンテナ・ランタイム仕様に準拠するリファレンス実装
- runC のみでCLIとして機能しコンテナの起動が可能（デーモン不要）
- コンテナの実行レイヤのコアランタイム

<div style="text-align:center;">
  <img src="images/runc.png" style="width:40%;"/>
</div>

---

#### containerd
- Docker のコアコンテナランタイム
- 実行中のコンテナの監視・管理
- コンテナイメージの管理（レジストリへのpush/pull）

![](images/containerd.png)

# Container Cloud Service <br>![](images/cloudgs_occs.png)

---

#### dockerd

- Docker >= 1.12 は、[docker daemon](https://docs.docker.com/v1.11/engine/reference/commandline/daemon/) が、[dockerd](https://docs.docker.com/engine/reference/commandline/dockerd/) に変更
- docker swarm との統合
- 1.11までは、クラスタ管理のために、Docker Engine とは別に Swarm マネージャ/Swarm ノードがj必要
- 1.12からは、dockerd がDocker Daemon の役割と、Swarm ノードの役割を担う

---

### Sub Slide

1. list
1. list

# Application Container Cloud Service <br>![](images/cloudgs_appcontainer.png)

---

### Sub Slide

1. list
1. list
