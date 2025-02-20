sudo apt update
sudo apt install git git-lfs zipalign apksigner
sudo git lfs install
git clone https://github.com/microg/GmsCore.git input
cd input
patch -t -s -p1 < ../gmscore.patch
export GRADLE_MICROG_VERSION_WITHOUT_GIT=0
./gradlew --no-daemon --stacktrace :play-services-core:assembleMapboxDefault :play-services-core:assembleMapboxHuawei
mkdir ../outputog
mkdir ../outputhw
cp play-services-core/build/outputs/apk/mapboxDefault/release/*.apk ../outputog
cp play-services-core/build/outputs/apk/mapboxHuawei/release/*.apk ../outputhw
zipalign -p 4 ../outputog/*.apk ../outputog/aligned.apk
zipalign -p 4 ../outputhw/*.apk ../outputhw/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputog/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputhw/aligned.apk
mkdir ../prebuilt
cp ../outputhw/aligned.apk ../prebuilt/gmscore-huawei.apk
cp ../outputog/aligned.apk ../prebuilt/gmscore-original.apk
