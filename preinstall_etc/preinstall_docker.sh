# https://docs.docker.com/engine/install/ubuntu/
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
# https://qiita.com/toyotoyo_/items/895c07fb50708b013eba
# 公式はapt-getを使用しているが、getに関しては差異はなさそうなのでaptでOK

sudo apt update
sudo apt install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# 確認
# sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update
apt-cache policy docker-ce

sudo apt install docker-ce docker-ce-cli containerd.io
# memo GRUB は以下のデバイスへのインストールに失敗しました:
# 何も選択せずに進めた(選んでも途中でこける)

docker --version
# sudo docker run hello-world

# sudoなしでdockerコマンドを叩けるようにする
sudo usermod -aG docker $USER

echo 'finished'
echo 'Hint: 一回抜けてwindows側でwsl -t Ubuntu-20.04で再起動'

# 確認
# sudo service docker start
# docker run hello-world
