#! /bin/bash
set -x
export RT_BRANCH=dev
#rm -rf RawTherapee
if [ ! -e RawTherapee ]; then
	git clone https://github.com/Beep6581/RawTherapee.git --branch $RT_BRANCH --single-branch
fi
rm -rf RawTherapee/ci
cp -a ci RawTherapee
cd RawTherapee
#docker run -it -v $(pwd):/sources -e "RT_BRANCH=$RT_BRANCH" photoflow/docker-centos7-gtk bash 
#/sources/ci/appimage-centos7.sh

#docker run -it -e "TRAVIS_BUILD_DIR=/sources" -e "TRAVIS_BRANCH=${RT_BRANCH}" -e "TRAVIS_COMMIT=${TRAVIS_COMMIT}" -v $(pwd):/sources photoflow/docker-buildenv-mingw bash #-c /sources/ci/package-w64.sh

echo "build-docker.sh 16"
docker run -it -v /etc/resolv.conf:/etc/resolv.conf.host -e "TRAVIS_BUILD_DIR=/sources" -e "TRAVIS_BRANCH=${RT_BRANCH}" -e "TRAVIS_COMMIT=${TRAVIS_COMMIT}" -v $(pwd):/sources photoflow/docker-buildenv-mingw-manjaro-wine bash #-c /sources/ci/package-w64.sh
echo "build-docker.sh 18"
