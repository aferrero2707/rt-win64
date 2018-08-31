#! /bin/bash
echo "Compiling RawTherapee"
ls /sources
(cd /sources; patch -p0 < ci/rtgui-options-headers.patch; patch -p0 < ci/rtgui-placesbrowser-headers.patch; patch -p0 < ci/rtdata-innosetup.patch)
(mkdir -p /work/w64-build && cd /work/w64-build) || exit 1
(crossroad cmake -DCMAKE_BUILD_TYPE=Release -DPROC_TARGET_NUMBER=1 \
 -DCACHE_NAME_SUFFIX="'5-dev'" \
 -DCMAKE_C_FLAGS="'-mwin32 -m64 -mthreads -msse2'" \
 -DCMAKE_C_FLAGS_RELEASE="'-DNDEBUG -O2'" \
 -DCMAKE_CXX_FLAGS="'-mwin32 -m64 -mthreads -msse2'" \
 -DCMAKE_CXX_FLAGS_RELEASE="'-Wno-aggressive-loop-optimizations -DNDEBUG -O3'" \
 -DCMAKE_EXE_LINKER_FLAGS="'-m64 -mthreads -static-libgcc'" \
 -DCMAKE_EXE_LINKER_FLAGS_RELEASE="'-s -O3'" \
 /sources && make -j 2 && make install) || (rm -f /work/w64-build/Release/rawtherapee.exe && exit 1)

echo ""
echo "########################################################################"
echo ""
echo "Install Hicolor and Adwaita icon themes"

(cd /work/w64-build && rm -rf hicolor-icon-theme-0.* && \
wget http://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.17.tar.xz && \
tar xJf hicolor-icon-theme-0.17.tar.xz && cd hicolor-icon-theme-0.17 && \
./configure --prefix=/zyx && make install && rm -rf hicolor-icon-theme-0.*) || exit 1
echo "icons after hicolor installation:"
ls /zyx/share/icons
echo ""

(cd /work/w64-build && rm -rf adwaita-icon-theme-3.* && \
wget http://ftp.gnome.org/pub/gnome/sources/adwaita-icon-theme/3.26/adwaita-icon-theme-3.26.0.tar.xz && \
tar xJf adwaita-icon-theme-3.26.0.tar.xz && cd adwaita-icon-theme-3.26.0 && \
./configure --prefix=/zyx && make install && rm -rf adwaita-icon-theme-3.26.0*) || exit 1
echo "icons after adwaita installation:"
ls /zyx/share/icons
echo ""

