#!/bin/bash

set -e

# Set Crave to build using LineageOS 21 as base
repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 --git-lfs

# Run inside foss.crave.io devspace, in the project folder
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/local_manifests && \
# Initialize repo with specified manifest
#repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs ;\

# Clone local_manifests repository
#git clone https://github.com/RadGoodNowYT/manifest.git .repo/local_manifests ;\

# Removals
rm -rf system/libhidl prebuilts/clang/host/linux-x86 prebuilt/*/webview.apk platform/external/python/pyfakefs platform/external/python/bumble external/chromium-webview/prebuilt/x86_64 platform/external/opencensus-java RisingOS_gsi patches device/phh/treble && \

# Sync the repositories
repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# Clone our GSI Repo
#git clone https://github.com/OkBuddyGSI/RisingOS_gsi -b 14 && \
#mv RisingOS_gsi/patches patches; \
#mv RisingOS_gsi/patches/RisingOS.mk device/phh/treble; \

# Apply Patches
#bash patches/apply-patches.sh . && \

# Set up build environment
cd device/itel/P682LPN
#bash generate.sh RisingOS && \
cd ../../.. && \
source build/envsetup.sh && \

# Lunch configuration
lunch P682LPN-userdebug ;\

croot ;\
make systemimage ; \
echo "Date and time:" ; \

# Print out/build_date.txt
cat out/build_date.txt; \

# Print SHA256
sha256sum out/target/product/*/*.img"

# Clean up
# rm -rf tissot/*

# Pull generated zip files
# crave pull out/target/product/*/*.zip 

# Pull generated img files
crave pull out/target/product/*/*.img

# Upload zips to Telegram
# telegram-upload --to sdreleases tissot/*.zip

#Upload to Github Releases
#curl -sf https://raw.githubusercontent.com/Meghthedev/Releases/main/headless.sh | sh
