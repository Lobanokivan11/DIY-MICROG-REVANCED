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
export GRADLE_MICROG_VERSION_WITHOUT_GIT=1
gradle --no-daemon :play-services-core:assembleMapboxDefault :play-services-core:assembleMapboxHuawei
mkdir ../outputog
mkdir ../outputhw
cp play-services-core/build/outputs/apk/mapboxDefault/release/*.apk ../outputog
cp play-services-core/build/outputs/apk/mapboxHuawei/release/*.apk ../outputhw
zipalign -p 4 ../outputog/*.apk ../outputog/aligned.apk
zipalign -p 4 ../outputhw/*.apk ../outputhw/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputog/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputhw/aligned.apk
cp ../outputhw/aligned.apk ../gmscore-huawei.apk
cp ../outputog/aligned.apk ../gmscore-original.apk
