sudo apt update
sudo apt install git git-lfs zipalign apksigner
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle
sudo git lfs install
git clone https://github.com/microg/GmsCore.git input
cd input
patch -t -s -p1 < ../gmscore.patch
export GRADLE_MICROG_VERSION_WITHOUT_GIT=0
gradle :play-services-core:assembleMapboxDefault :play-services-core:assembleMapboxHuawei :vending-app:assembledefault :vending-app:assemblehuawei
mkdir ../outputog
mkdir ../outputhw
mkdir ../outputoggp
mkdir ../outputhwgp
cp vending-app/build/outputs/apk/default/release/*.apk ../outputoggp
cp vending-app/build/outputs/apk/huawei/release/*.apk  ../outputhwgp
cp play-services-core/build/outputs/apk/mapboxDefault/release/*.apk ../outputog
cp play-services-core/build/outputs/apk/mapboxHuawei/release/*.apk ../outputhw
zipalign -p 4 ../outputog/*.apk ../outputog/aligned.apk
zipalign -p 4 ../outputhw/*.apk ../outputhw/aligned.apk
zipalign -p 4 ../outputoggp/*.apk ../outputoggp/aligned.apk
zipalign -p 4 ../outputhwgp/*.apk ../outputhwgp/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputog/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputhw/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputoggp/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputhwgp/aligned.apk
mkdir ../prebuilt
cp ../outputhw/aligned.apk ../prebuilt/gmscore-huawei.apk
cp ../outputog/aligned.apk ../prebuilt/gmscore-original.apk
cp ../outputhwgp/aligned.apk ../prebuilt/vending-huawei.apk
cp ../outputoggp/aligned.apk ../prebuilt/vending-original.apk
