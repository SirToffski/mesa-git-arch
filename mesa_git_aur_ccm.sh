#!/usr/bin/env bash

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

clone_upstream() {
    mkdir -p /home/toffski/aur-pkg/mesa-git-aur
    cd /home/toffski/aur-pkg/mesa-git-aur || exit

    rm -rf ./python-sphinx-automodapi
    rm -rf ./llvm-git
    rm -rf ./lib32-llvm-git
    rm -rf ./mesa-git
    rm -rf ./lib32-mesa-git
    rm -rf ./xf86-video-amdgpu-git
    rm -rf ./xf86-video-intel-git

    git clone https://aur.archlinux.org/python-sphinx-automodapi.git
    git clone https://aur.archlinux.org/llvm-git.git
    git clone https://aur.archlinux.org/lib32-llvm-git.git
    git clone https://aur.archlinux.org/mesa-git.git
    git clone https://aur.archlinux.org/lib32-mesa-git.git
    git clone https://aur.archlinux.org/xf86-video-amdgpu-git.git
    git clone https://aur.archlinux.org/xf86-video-intel-git.git
}

remove_packages_from_repo() {
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst python-sphinx-automodapi*
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst llvm-git*
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst lib32-git*
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst mesa-git*
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst lib32-mesa-git*
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst xf86-video-amdgpu-git*
    repo-remove /home/toffski/toff_build_repo/toff-repo.db.tar.zst xf86-video-intel-git*
}

main() {
    clone_upstream
    remove_packages_from_repo
    sudo bash "$script_directory/mesa_git_aur_ccm_build.sh"
}

main
