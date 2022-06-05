#!/usr/bin/env bash

elevated_build_tasks() {

    build_llvm-minimal-git() {
        pacman -Syyu --noconfirm
        sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/makepkg-x86_64_O3\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm n
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/llvm-minimal-git || exit
        ccm s
    }

    build_lib32-llvm-minimal-git() {
        pacman -Syyu --noconfirm
        ccm n
        ccm c
        cd /home/toffski/aur-pkg/mesa-git-aur/lib32-llvm-minimal-git || exit
        ccm s
    }

    build_llvm-minimal-git || exit
    build_lib32-llvm-minimal-git || exit
}

elevated_build_tasks
