#!/usr/bin/env bash

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

clone_upstream() {
    mkdir -p /home/toffski/arch-llvm/mesa-git-aur
    cd /home/toffski/arch-llvm/mesa-git-aur || exit

    rm -rf ./python-sphinx-automodapi
    rm -rf ./llvm-git
    rm -rf ./mesa-git
    rm -rf ./xf86-video-amdgpu-git

    git clone https://aur.archlinux.org/python-sphinx-automodapi.git
    git clone https://github.com/SirToffski/llvm-git-PKGBUILD.git llvm-git
    git clone https://github.com/SirToffski/mesa-git-PKGBUILD.git mesa-git
    git clone https://aur.archlinux.org/xf86-video-amdgpu-git.git

    sudo ccm d
    repo-add /home/toffski/toff_build_repo/toff-repo.db.tar.gz
}

main() {
    clone_upstream
    sudo bash "$script_directory/mesa_git_aur_ccm_build.sh"
}

main
