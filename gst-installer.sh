#!/bin/bash
read -sp "Password: " password
echo

srcbranch="origin/1.12"
confflag="--prefix=/usr/local"
libpath="-L/usr/local/lib/"
workpath="./gst"

if [ -e ${workpath} ]
then
	rm -rf ${workpath}
fi

mkdir ${workpath}
cd ${workpath}

export LIB="$LIB ${libpath}"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

set -e

echo "$password" | sudo -S apt install -y bison flex autoconf liborc*

git clone https://github.com/GStreamer/gstreamer.git
cd gstreamer
git checkout ${srcbranch}
./autogen.sh --noconfigure
set -x
./configure ${confflag}
make -j4
set +x
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

git clone https://github.com/GStreamer/gst-plugins-base.git
cd gst-plugins-base
git checkout ${srcbranch}
./autogen.sh --noconfigure
./configure ${confflag}
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

echo "$password" | sudo -S apt install -y libjpeg-dev libvpx-dev
git clone https://github.com/GStreamer/gst-plugins-good.git
cd gst-plugins-good
git checkout ${srcbranch}
./autogen.sh --noconfigure
./configure ${confflag}
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

echo "$password" | sudo -S apt install -y x265
git clone https://github.com/GStreamer/gst-plugins-bad.git
cd gst-plugins-bad
git checkout ${srcbranch}
./autogen.sh --noconfigure
./configure ${confflag}
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

echo "$password" | sudo -S apt install -y libx264-dev libmpg123-dev
git clone https://github.com/GStreamer/gst-plugins-ugly.git
cd gst-plugins-ugly
git checkout ${srcbranch}
./autogen.sh --noconfigure
./configure ${confflag}
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

git clone https://github.com/GStreamer/gst-libav.git
cd gst-libav
git checkout ${srcbranch}
./autogen.sh --noconfigure
./configure ${confflag}
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

git clone https://anongit.freedesktop.org/git/gstreamer/gst-ffmpeg.git
cd gst-ffmpeg
git checkout ${srcbranch}
./autogen.sh --noconfigure
./configure ${confflag}
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

git clone https://github.com/GStreamer/gst-rtsp-server.git
cd gst-rtsp-server
git checkout ${srcbranch}
./autogen.sh --noconfigure
./configure ${confflag}
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

git clone https://github.com/GStreamer/gst-omx.git
cd gst-omx
git checkout ${srcbranch}
export LDFLAGS="-L/opt/vc/lib -lGLESv2 -lbcm_host -lEGL -lm -lstdc++"
export CPPFLAGS="-I/opt/vc/include -I/opt/vc/include/IL -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux"
./autogen.sh --noconfigure 
./configure ${confflag} \
--with-omx-target=rpi
make -j4
echo "$password" | sudo -S make install
echo "$password" | sudo -S ldconfig
cd ../

echo "export GST_OMX_CONFIG_DIR=/usr/local/etc/xdg/" >> ~/.bashrc
echo "export GST_PLUGIN_PATH=/usr/local/lib/gstreamer-1.0/" >> ~/.bashrc

source ~/.bashrc
