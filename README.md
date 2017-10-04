# gst-installer
Gstreamer をソースからインストールする便利スクリプト．

# 使い方
git clone してできたディレクトリで，gst-installer.shを実行する．
実行するとすぐにsudoのパスワードを聞かれるので入力する．
その後，gst-installerディレクトリの下にgstというディレクトリを作り，そこにGstreamerのリポジトリをcloneしてきてビルド作業が始まる．

```
$git clone http://172.20.0.20:8000/KIR/gst-installer.git
$cd gst-installer
$./gst-installer.sh
password:
```
