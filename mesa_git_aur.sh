#!/usr/bin/env bash

clone_upstream() {
    mkdir -p /home/toffski/aur-pkg/mesa-gitlab
    cd /home/toffski/aur-pkg/mesa-gitlab || exit

    rm -rf ./llvm-minimal-git
    rm -rf ./lib32-llvm-minimal-git
    rm -rf ./mesa-git
    rm -rf ./lib32-mesa-git
    rm -rf ./xf86-video-amdgpu-git
    rm -rf ./xf86-video-intel-git

    git clone https://aur.archlinux.org/llvm-minimal-git.git
    git clone https://aur.archlinux.org/lib32-llvm-minimal-git.git
    git clone https://aur.archlinux.org/mesa-git.git
    git clone https://aur.archlinux.org/lib32-mesa-git.git
    git clone https://aur.archlinux.org/xf86-video-amdgpu-git.git
    git clone https://aur.archlinux.org/xf86-video-intel-git.git
}

build_llvm-minimal-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-gitlab/llvm-minimal-git || exit
    MESA_WHICH_LLVM=1 paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst *.pkg.tar.zst
    sudo pacman -Syyy
}

build_mesa-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-gitlab/mesa-git || exit
    sed -i 's/    MESA_WHICH_LLVM=4/    MESA_WHICH_LLVM=1/g' PKGBUILD
    MESA_WHICH_LLVM=1 paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst *.pkg.tar.zst
    sudo pacman -Syyy
}

build_lib32-llvm-minimal-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-gitlab/lib32-llvm-minimal-git || exit
    paru -U --sudoloop --localrepo --mflags "--nocheck" --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst *.pkg.tar.zst
    sudo pacman -Syyy
}

build_lib32-mesa-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-gitlab/lib32-mesa-git || exit
    sed -i 's/    MESA_WHICH_LLVM=4/    MESA_WHICH_LLVM=1/g' PKGBUILD
    MESA_WHICH_LLVM=1 paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst *.pkg.tar.zst
    sudo pacman -Syyy
}

build_xf86-video-amdgpu-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-gitlab/xf86-video-amdgpu-git || exit
    MESA_WHICH_LLVM=1 paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
}

xf86-video-intel-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-gitlab/xf86-video-intel-git || exit
    MESA_WHICH_LLVM=1 paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
}

main() {
    clone_upstream
    build_llvm-minimal-git
    build_mesa-git
    build_lib32-llvm-minimal-git
    build_lib32-mesa-git
    build_xf86-video-amdgpu-git
    xf86-video-intel-git
}

main
