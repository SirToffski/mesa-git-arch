#!/usr/bin/env bash

clone_upstream() {
    mkdir -p /home/toffski/aur-pkg/mesa-git-aur
    cd /home/toffski/aur-pkg/mesa-git-aur || exit

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

remove_packages_from_repo() {
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst llvm-minimal-git.*.pkg.tar.zst
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst lib32-llvm-minimal-git.*.pkg.tar.zst
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst mesa-git.*.pkg.tar.zst
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst lib32-mesa-git.*.pkg.tar.zst
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst xf86-video-amdgpu-git.*.pkg.tar.zst
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst xf86-video-intel-git.*.pkg.tar.zst
}

build_llvm-minimal-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-git-aur/llvm-minimal-git || exit
    paru -U --sudoloop --localrepo --mflags "--nocheck" --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst llvm-minimal-git*.pkg.tar.zst
    sudo pacman -Syyu --noconfirm
}

build_mesa-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-git-aur/mesa-git || exit
    sed -i 's/    MESA_WHICH_LLVM=4/    MESA_WHICH_LLVM=1/g' PKGBUILD
    MESA_WHICH_LLVM=1 paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst mesa-git*.pkg.tar.zst
    sudo pacman -Syyu --noconfirm
}

build_lib32-llvm-minimal-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-git-aur/lib32-llvm-minimal-git || exit
    paru -U --sudoloop --localrepo --mflags "--nocheck" --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst lib32-llvm-minimal-git*.pkg.tar.zst
    sudo pacman -Syyu --noconfirm
}

build_lib32-mesa-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-git-aur/lib32-mesa-git || exit
    sed -i 's/    MESA_WHICH_LLVM=4/    MESA_WHICH_LLVM=1/g' PKGBUILD
    MESA_WHICH_LLVM=1 paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst lib32-mesa-git*.pkg.tar.zst
    sudo pacman -Syyu --noconfirm
}

build_xf86-video-amdgpu-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-git-aur/xf86-video-amdgpu-git || exit
    paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst xf86-video-amdgpu-git*.pkg.tar.zst
}

build_xf86-video-intel-git() {
    sudo ccm n
    sudo ccm c
    cd /home/toffski/aur-pkg/mesa-git-aur/xf86-video-intel-git || exit
    paru -U --sudoloop --localrepo --chroot='/home/toffski/toff_build_chroot/' --noconfirm
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.zst xf86-video-amdgpu-git*.pkg.tar.zst
}

main() {
    clone_upstream
    remove_packages_from_repo
    build_llvm-minimal-git
    build_mesa-git
    build_lib32-llvm-minimal-git
    build_lib32-mesa-git
    build_xf86-video-amdgpu-git
    build_xf86-video-intel-git
}

main
