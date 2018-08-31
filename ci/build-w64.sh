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
