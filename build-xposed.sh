sudo apt update
sudo apt install git git-lfs zipalign apksigner
git lfs install
git submodule update --init --recursive
git clone https://github.com/kuomartin/MicroGLogin.git MicroGLogin
cd MicroGLogin
./gradlew assembleDebug
mkdir ../output
cp app/build/outputs/apk/debug/app-debug.apk ../output
zipalign -p 4 ../output/app-debug.apk ../output/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../output/aligned.apk
mkdir ../prebuilt
cp ../output/aligned.apk ../prebuilt/MG-XPOSED.apk
