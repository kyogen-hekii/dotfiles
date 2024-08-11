mkdir ~/tmp
curl -L https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip --output ~/tmp/HackGen_NF.zip
# unzipはworkdirに作られる
unzip ~/tmp/HackGen_NF.zip
rm ~/tmp/HackGen_NF.zip
mkdir ~/.local/share/fonts
mv HackGen_NF_v2.9.0 ~/.local/share/fonts/HackGen_NF
# ls ~/.local/share/fonts/HackGen_NF
# => HackGenNerd_v2.9.0_BoldItalic.ttf  HackGenNerd_v2.9.0_Regular.ttf  HackGenNerd_v2.9.0_Bold.ttf  HackGenNerd_v2.9.0_Italic.ttf

# 反映
fc-cache -fv

# @echo あとは利用したいツールにフォントの設定でHackGen Console NFを指定すれば反映されます。
