sudo apt update
sudo apt install git git-lfs
sudo apt install openjdk-17
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle
sudo git lfs install
git clone https://github.com/microg/GmsCore.git input
cd input
patch -t -s -p1 < ../gmscore.patch
