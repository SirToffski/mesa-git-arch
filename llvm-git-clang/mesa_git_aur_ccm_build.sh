#!/usr/bin/env bash

elevated_build_tasks() {

    build_python-sphinx-automodapi() {
        pacman -Syyu --noconfirm
        ccm n

        sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/makepkg-x86_64_LLVM\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf

        sed -i -E 's/.*USELLVM.*/USELLVM=1/g' \
            /home/toffski/.config/clean-chroot-manager.conf

        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/python-sphinx-automodapi || exit
        ccm s
    }

    build_llvm-git() {
        pacman -Syyu --noconfirm
        ccm n
        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/llvm-git || exit
        ccm s
    }

    build_mesa-git() {
        cd /home/toffski/llvm-git || exit
        rm -rf ./*

        cd /home/toffski/toff_build_repo || exit

        for file in llvm*.pkg.tar.zst; do
            cp "$file" /home/toffski/llvm-git/"$file"
        done

        cd /home/toffski/llvm-git || exit

        repo-add llvm-git.db.tar.gz ./*

        pacman -Syyu --noconfirm
        ccm n

        sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/makepkg-x86_64_O3_LLVM\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf

        sed -i -E 's/.*USELLVM.*/#USELLVM=1/g' \
            /home/toffski/.config/clean-chroot-manager.conf

        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/mesa-git || exit
        sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=2/g' PKGBUILD
        ccm s
    }

    build_xf86-video-amdgpu-git() {
        pacman -Syyu --noconfirm
        ccm n
        sed -i -E 's/.*USELLVM.*/USELLVM=1/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/xf86-video-amdgpu-git || exit
        ccm s
    }

    build_python-sphinx-automodapi || exit
    build_llvm-git || exit
    build_mesa-git || exit
    build_xf86-video-amdgpu-git || exit

}

elevated_build_tasks
