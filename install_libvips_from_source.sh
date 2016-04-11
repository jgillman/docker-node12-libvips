#!/usr/bin/env bash

# Copied from https://raw.githubusercontent.com/lovell/sharp/master/preinstall.sh

vips_version_latest_major_minor=8.2
vips_version_latest_patch=3

install_libvips_from_source() {
  echo "Compiling libvips $vips_version_latest_major_minor.$vips_version_latest_patch from source"
  curl -O http://www.vips.ecs.soton.ac.uk/supported/$vips_version_latest_major_minor/vips-$vips_version_latest_major_minor.$vips_version_latest_patch.tar.gz
  tar zvxf vips-$vips_version_latest_major_minor.$vips_version_latest_patch.tar.gz
  cd vips-$vips_version_latest_major_minor.$vips_version_latest_patch || exit 1
  ./configure --disable-debug --disable-docs --disable-static --disable-introspection --disable-dependency-tracking --enable-cxx=yes --without-python --without-orc --without-fftw "$1"
  make
  make install
  cd ..
  rm -rf vips-$vips_version_latest_major_minor.$vips_version_latest_patch
  rm vips-$vips_version_latest_major_minor.$vips_version_latest_patch.tar.gz
  ldconfig
  echo "Installed libvips $(PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig pkg-config --modversion vips)"
}

install_libvips_from_source "$@"
