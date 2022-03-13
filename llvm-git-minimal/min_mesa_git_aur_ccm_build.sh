#!/usr/bin/env bash

clone_directory="/home/$USER/aur-pkg/mesa-git-aur"

elevated_build_tasks() {

    build_python-sphinx-automodapi() {
        pacman -Syyu --noconfirm
        ccm n
        # make sure python-sphinx-automodapi and llvm are compiled -march=x86-64 -mtune=generic because
        # we are building on a remove machine
        sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/usr\/share\/devtools\/makepkg-x86_64\.conf"/g' \
            /home/"$USER"/.config/clean-chroot-manager.conf
        ccm c
        cd "$clone_directory"/python-sphinx-automodapi || exit
        ccm s
    }

    build_llvm-minimal-git() {
        pacman -Syyu --noconfirm
        ccm n
        ccm c
        cd "$clone_directory"/llvm-minimal-git || exit
        ccm s
    }

    build_mesa-git() {
        pacman -Syyu --noconfirm
        ccm n
        # build mesa-git with optimizations for ivybridge;
        # to do that, we'll specify a different makepkg.conf file
        sed -i -E "s/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/$USER\/makepkg-x86_64_O3\.conf\"/g" \
            /home/"$USER"/.config/clean-chroot-manager.conf
        ccm c
        cd "$clone_directory"/mesa-git || exit
        # use aur llvm-minimal-git
        sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=1/g' PKGBUILD
        # optionally, uncomment below to build without OpenCL
        # sed -i 's/gallium-opencl=icd/gallium-opencl=disabled/g' PKGBUILD
        ccm s
    }

    build_lib32-llvm-minimal-git() {
        pacman -Syyu --noconfirm
        ccm n
        # make sure python-sphinx-automodapi and llvm are compiled -march=x86-64 -mtune=generic because
        # we are building on a remove machine
        sed -i -E 's/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/usr\/share\/devtools\/makepkg-x86_64\.conf"/g' \
            /home/"$USER"/.config/clean-chroot-manager.conf
        ccm c
        cd "$clone_directory"/lib32-llvm-minimal-git || exit
        ccm s
    }

    build_lib32-mesa-git() {
        pacman -Syyu --noconfirm
        ccm n
        # build mesa-git with optimizations for ivybridge;
        # to do that, we'll specify a different makepkg.conf file
        sed -i -E "s/.*CUSTOM_MAKEPKG_CONF.*/CUSTOM_MAKEPKG_CONF=\"\/home\/$USER\/makepkg-x86_64_O3\.conf\"/g" \
            /home/"$USER"/.config/clean-chroot-manager.conf
        ccm c
        cd "$clone_directory"/lib32-mesa-git || exit
        # use aur lib32-llvm-minimal-git
        sed -i 's/ MESA_WHICH_LLVM=4/ MESA_WHICH_LLVM=1/g' PKGBUILD
        ccm s
    }

    build_xf86-video-amdgpu-git() {
        pacman -Syyu --noconfirm
        ccm n
        ccm c
        cd "$clone_directory"/xf86-video-amdgpu-git || exit
        ccm s
    }

    # build_xf86-video-intel-git() {
    #    pacman -Syyu --noconfirm
    #    ccm n
    #    ccm c
    #    cd "$clone_directory"/xf86-video-intel-git || exit
    #    wget 'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/xf86-video-intel/trunk/PKGBUILD'
    #    wget 'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/xf86-video-intel/trunk/xf86-video-intel.install'
    #    ccm s
    # }

    build_python-sphinx-automodapi || exit
    build_llvm-minimal-git || exit
    build_mesa-git || exit
    build_lib32-llvm-minimal-git || exit
    build_lib32-mesa-git || exit
    build_xf86-video-amdgpu-git || exit
    # build_xf86-video-intel-git || exit

}

elevated_build_tasks
