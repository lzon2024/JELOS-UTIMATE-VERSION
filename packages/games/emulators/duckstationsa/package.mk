# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="duckstationsa"
PKG_VERSION="82965f741e81e4d2f7e1b2abdc011e1f266bfe7f"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/stenzek/duckstation"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 nasm:host ${OPENGLES} libevdev"
PKG_SECTION="libretro"
PKG_SHORTDESC="Fast PlayStation 1 emulator for x86-64/AArch32/AArch64 "
PKG_TOOLCHAIN="cmake"

EXTRA_OPTS+=" -DUSE_DRMKMS=ON -DUSE_FBDEV=OFF -DUSE_MALI=OFF"
#EXTRA_OPTS+=" -DUSE_DRMKMS=OFF -DUSE_FBDEV=ON -DUSE_MALI=ON"

pre_configure_target() {
	PKG_CMAKE_OPTS_TARGET+=" -DANDROID=OFF \
	                         -DBUILD_LIBRETRO_CORE=OFF \
	                         -DENABLE_DISCORD_PRESENCE=OFF \
	                         -DUSE_X11=OFF \
	                         -DBUILD_GO2_FRONTEND=OFF \
	                         -DBUILD_QT_FRONTEND=OFF \
	                         -DBUILD_NOGUI_FRONTEND=ON \
	                         -DCMAKE_BUILD_TYPE=Release \
	                         -DBUILD_SHARED_LIBS=OFF \
	                         -DUSE_SDL2=ON \
	                         -DENABLE_CHEEVOS=ON \
	                         -DHAVE_EGL=ON \
	                         ${EXTRA_OPTS}"


}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/duckstation-nogui ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/config/duckstation
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/* ${INSTALL}/usr/config/duckstation
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/duckstation

  rm -rf ${INSTALL}/usr/config/duckstation-nogui
  rm -rf ${INSTALL}/usr/config/duckstation/common-tests

 chmod +x ${INSTALL}/usr/bin/duckstation.sh
}
