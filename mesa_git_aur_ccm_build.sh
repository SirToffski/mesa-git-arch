#!/usr/bin/env bash

elevated_build_tasks() {

ccm d

    build_python-sphinx-automodapi() {
        pacman -Syyu --noconfirm
        ccm n
        rm /home/toffski/toff_build_repo/python-sphinx-automodapi*.pkg.tar.zst
        sed -i -E 's/CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/etc\/makepkg\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/python-sphinx-automodapi || exit
        ccm s
    }

    build_llvm-git() {
        pacman -Syyu --noconfirm
        ccm n
        rm /home/toffski/toff_build_repo/llvm-git*.pkg.tar.zst
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/llvm-git || exit
        ccm s
    }

    build_mesa-git() {
        pacman -Syyu --noconfirm
        ccm n
        rm /home/toffski/toff_build_repo/mesa-git*.pkg.tar.zst
        sed -i -E 's/CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/\.makepkg\.laptop\.o3\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/mesa-git || exit
        sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=2/g' PKGBUILD
        sed -i 's/gallium-opencl=icd/gallium-opencl=disabled/g' PKGBUILD
        ccm s
    }

    build_lib32-llvm-git() {
        pacman -Syyu --noconfirm
        ccm n
        rm /home/toffski/toff_build_repo/lib32-llvm-git*.pkg.tar.zst
        sed -i -E 's/CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/etc\/makepkg\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/lib32-llvm-git || exit
        sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=2/g' PKGBUILD
        ccm s
    }

    build_lib32-mesa-git() {
        pacman -Syyu --noconfirm
        ccm n
        rm /home/toffski/toff_build_repo/lib32-mesa-git*.pkg.tar.zst
        sed -i -E 's/CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/\.makepkg\.laptop\.o3\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/lib32-mesa-git || exit
        sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=2/g' PKGBUILD
        ccm s
    }

    build_xf86-video-amdgpu-git() {
        pacman -Syyu --noconfirm
        ccm n
        rm /home/toffski/toff_build_repo/xf86-video-amdgpu-git*.pkg.tar.zst
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/xf86-video-amdgpu-git || exit
        ccm s
    }

    build_xf86-video-intel-git() {
        pacman -Syyu --noconfirm
        ccm n
        rm /home/toffski/toff_build_repo/xf86-video-intel-git*.pkg.tar.zst
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/xf86-video-intel-git || exit
        ccm s
    }

    build_python-sphinx-automodapi || exit
    build_llvm-git || exit
    build_mesa-git || exit
    build_lib32-llvm-git || exit
    build_lib32-mesa-git || exit
    build_xf86-video-amdgpu-git || exit
    build_xf86-video-intel-git || exit

}

elevated_build_tasks
