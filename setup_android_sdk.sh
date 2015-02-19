#!/bin/bash

# install android [sn]dk
curl http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz | tar xz
./android-sdk-linux/tools/android update sdk --no-ui --obsolete --force

wget http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
chmod +x android-ndk-r10d-linux-x86_64.bin
./android-ndk-r10d-linux-x86_64.bin



