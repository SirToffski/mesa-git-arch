#!/usr/bin/env bash

elevated_build_tasks() {

    build_python-sphinx-automodapi() {
        pacman -Syyu --noconfirm
        ccm n
        sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/makepkg-x86_64_LLVM\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        sed -i -E 's/.*USELLVM.*/USELLVM=1/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        # sed -i -E 's/.*CUSTOM_PACMAN_CONF.*/#CUSTOM_PACMAN_CONF=\"\/etc\/pacman\.conf"/g' \
        #     /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/python-sphinx-automodapi || exit
        ccm s
    }

    build_llvm-git() {
        pacman -Syyu --noconfirm
        # sed -i -E 's/.*CUSTOM_PACMAN_CONF.*/#CUSTOM_PACMAN_CONF=\"\/etc\/pacman\.conf"/g' \
        #     /home/toffski/.config/clean-chroot-manager.conf
        ccm n
        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/llvm-git || exit
        ccm s
    }

    build_mesa-git() {
        cd /home/toffski/llvm-git || exit
        rm -rf ./*

        cp /home/toffski/toff_build_repo/llvm-git-*.pkg.tar.zst \
            /home/toffski/llvm-git/llvm-git.pkg.tar.zst

        cp /home/toffski/toff_build_repo/llvm-libs-git-*.pkg.tar.zst \
            /home/toffski/llvm-git/llvm-libs-git.pkg.tar.zst

        cp /home/toffski/toff_build_repo/llvm-ocaml-git-*.pkg.tar.zst \
            /home/toffski/llvm-git/llvm-ocaml-git.pkg.tar.zst

        repo-add llvm-git.db.tar.gz ./*    
        
        pacman -Syyu --noconfirm
        ccm n
        sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/makepkg-x86_64_O3_LLVM\.conf\"/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        # sed -i -E 's/.*CUSTOM_PACMAN_CONF.*/#CUSTOM_PACMAN_CONF=\"\/etc\/pacman\.conf"/g' \
        #     /home/toffski/.config/clean-chroot-manager.conf
        sed -i -E 's/.*USELLVM.*/#USELLVM=1/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/mesa-git || exit
        sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=2/g' PKGBUILD
        # sed -i 's/gallium-opencl=icd/gallium-opencl=disabled/g' PKGBUILD
        ccm s
    }

    # build_lib32-llvm-git() {
    #     pacman -Syyu --noconfirm
    #     ccm n
    #     sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/usr\/share\/devtools\/makepkg-x86_64\.conf"/g' \
    #         /home/toffski/.config/clean-chroot-manager.conf
    #     sed -i -E 's/.*CUSTOM_PACMAN_CONF.*/CUSTOM_PACMAN_CONF=\"\/usr\/share\/devtools\/pacman-multilib\.conf"/g' \
    #         /home/toffski/.config/clean-chroot-manager.conf
    #     ccm c
    #     cd /home/toffski/arch-llvm/mesa-git-aur/lib32-llvm-git || exit
    #     ccm s
    # }

    # build_lib32-mesa-git() {
    #     pacman -Syyu --noconfirm
    #     ccm n
    #     sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/makepkg-x86_64_O3\.conf\"/g' \
    #         /home/toffski/.config/clean-chroot-manager.conf
    #     sed -i -E 's/.*CUSTOM_PACMAN_CONF.*/CUSTOM_PACMAN_CONF=\"\/usr\/share\/devtools\/pacman-multilib\.conf"/g' \
    #         /home/toffski/.config/clean-chroot-manager.conf
    #     ccm c
    #     cd /home/toffski/arch-llvm/mesa-git-aur/lib32-mesa-git || exit
    #     sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=2/g' PKGBUILD
    #     ccm s
    # }

    build_xf86-video-amdgpu-git() {
        pacman -Syyu --noconfirm
        # sed -i -E 's/.*CUSTOM_PACMAN_CONF.*/#CUSTOM_PACMAN_CONF=\"\/etc\/pacman\.conf"/g' \
        #     /home/toffski/.config/clean-chroot-manager.conf
        ccm n
        sed -i -E 's/.*USELLVM.*/USELLVM=1/g' \
            /home/toffski/.config/clean-chroot-manager.conf
        ccm c
        cd /home/toffski/arch-llvm/mesa-git-aur/xf86-video-amdgpu-git || exit
        ccm s
    }

    # build_xf86-video-intel-git() {
    #    pacman -Syyu --noconfirm
    #    ccm n
    #    ccm c
    #    cd /home/toffski/arch-llvm/mesa-git-aur/xf86-video-intel-git || exit
    #    wget 'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/xf86-video-intel/trunk/PKGBUILD'
    #    wget 'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/xf86-video-intel/trunk/xf86-video-intel.install'
    #    ccm s
    # }
    # rebuild_llvm-git() {
    #     pacman -Syyu --noconfirm
    #     rm -rf /home/toffski/toff_build_repo/{llvm-git*.pkg.tar.zst, llvm-ocaml-git*.pkg.tar.zst, llvm-libs-git*.pkg.tar.zst}
    #     sed -i -E 's/.*CUSTOM_PACMAN_CONF.*/#CUSTOM_PACMAN_CONF=\"\/etc\/pacman\.conf"/g' \
    #         /home/toffski/.config/clean-chroot-manager.conf
    #     sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/toffski\/makepkg-x86_64_O3\.conf\"/g' \
    #         /home/toffski/.config/clean-chroot-manager.conf
    #     ccm n
    #     ccm c
    #     cd /home/toffski/arch-llvm/mesa-git-aur/llvm-git-O3 || exit
    #     ccm s
    # }

    build_python-sphinx-automodapi || exit
    build_llvm-git || exit
    build_mesa-git || exit
    # build_lib32-llvm-git || exit
    # build_lib32-mesa-git || exit
    build_xf86-video-amdgpu-git || exit
    # build_xf86-video-intel-git || exit
    # rebuild_llvm-git || exit

}

elevated_build_tasks
