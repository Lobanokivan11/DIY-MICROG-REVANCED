sudo apt update
sudo apt install git git-lfs zipalign apksigner
git lfs install
git submodule update --init --recursive
git clone https://github.com/microg/GmsCore.git input
cd input
patch -t -s -p1 < ../gmscore.patch
cp -r ../profiles/*.xml play-services-core/src/main/res/xml
export GRADLE_MICROG_VERSION_WITHOUT_GIT=0
./gradlew :play-services-core:assembleMapboxUser
mkdir ../output
cp play-services-core/build/outputs/apk/mapboxUser/release/*.apk ../output
zipalign -p 4 ../output/*.apk ../output/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../output/aligned.apk
mkdir ../prebuilt
cp ../output/aligned.apk ../prebuilt/gmscore-user.apk
