#!/bin/bash
set -ev
source /opt/*/bin/qt*-env.sh
qmake -v
mkdir Tiled ; cd Tiled/
qmake ../tiled.pro
make || true # make[1]: /opt/qt57/bin/lrelease: Command not found
rm -rf src/
mv bin/* . && rm -r bin/ # Workaround for https://github.com/probonopd/linuxdeployqt/issues/14
cd ../
cp LICENSE* COPYING *md Tiled/
cp ./tiled.desktop Tiled/
cp ./src/tiled/images/32x32/tiled.png Tiled/
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/1/linuxdeployqt-1-x86_64.AppImage"
chmod a+x linuxdeployqt-1-x86_64.AppImage
unset LD_LIBRARY_PATH
./linuxdeployqt-1-x86_64.AppImage ./Tiled/tiled -appimage -verbose=2
