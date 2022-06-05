#!/usr/bin/env bash

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

clone_upstream() {
    mkdir -p /home/toffski/aur-pkg/mesa-git-aur
    cd /home/toffski/aur-pkg/mesa-git-aur || exit

    rm -rf ./python-sphinx-automodapi
    rm -rf ./llvm-git
    # rm -rf ./lib32-llvm-git
    rm -rf ./mesa-git
    # rm -rf ./lib32-mesa-git
    rm -rf ./xf86-video-amdgpu-git
    # rm -rf ./xf86-video-intel-git

    git clone https://aur.archlinux.org/python-sphinx-automodapi.git
    git clone https://aur.archlinux.org/llvm-git.git
    #git clone https://aur.archlinux.org/llvm-git.git llvm-git-O3
    #git clone https://aur.archlinux.org/lib32-llvm-git.git
    # git clone https://gist.github.com/SirToffski/37b5022a05ab8a62d9e26270912da7b7 mesa-git
    #cd /home/toffski/aur-pkg/mesa-git-aur/mesa-git
    #rm PKGBUILD
    #wget --https-only 'https://gist.githubusercontent.com/SirToffski/37b5022a05ab8a62d9e26270912da7b7/raw/b470f5ac465da63f083cfd86ae75ed18d505dec1/clover-llvm.patch'
    #wget --https-only 'https://gist.githubusercontent.com/SirToffski/37b5022a05ab8a62d9e26270912da7b7/raw/b470f5ac465da63f083cfd86ae75ed18d505dec1/PKGBUILD'
    #cd /home/toffski/aur-pkg/mesa-git-aur || exit
    git clone https://aur.archlinux.org/mesa-git.git
    # git clone https://aur.archlinux.org/lib32-mesa-git.git
    git clone https://aur.archlinux.org/xf86-video-amdgpu-git.git
    # mkdir -p /home/toffski/aur-pkg/mesa-git-aur/xf86-video-intel-git
    
    sudo ccm d
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.gz
}

main() {
    clone_upstream
    sudo bash "$script_directory/mesa_git_aur_ccm_build.sh"
}

main
