#!/usr/bin/env bash

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

clone_directory="/home/$USER/aur-pkg/mesa-git-aur"
local_repo_directory="/home/$USER/${USER}_build_repo"

date_dir="$(date +%d-%b-%Y)"

backup_existing_pkg() {

    if [[ -d "$local_repo_directory" ]]; then
        cd "$local_repo_directory"
        mkdir -p /home/"$USER"/pkg/"$date_dir"

        for pkg in ./*.pkg.tar.zst; do
            cp "$pkg" /home/"$USER"/pkg/"$date_dir"/"$pkg"
        done

    fi
}

clone_upstream() {
    mkdir -p "$clone_directory"
    cd "$clone_directory" || exit

    rm -rf ./python-sphinx-automodapi
    rm -rf ./llvm-minimal-git
    rm -rf ./lib32-llvm-minimal-git
    rm -rf ./mesa-git
    rm -rf ./lib32-mesa-git
    rm -rf ./xf86-video-amdgpu-git

    git clone https://aur.archlinux.org/python-sphinx-automodapi.git
    git clone https://aur.archlinux.org/llvm-minimal-git.git
    git clone https://aur.archlinux.org/lib32-llvm-minimal-git.git
    git clone https://aur.archlinux.org/mesa-git.git
    git clone https://aur.archlinux.org/lib32-mesa-git.git
    git clone https://aur.archlinux.org/xf86-video-amdgpu-git.git

    #backup all existing packages in the build repo
    backup_existing_pkg
    # clear everything out from existing local repository
    sudo ccm d
    # re-create our local repo
    repo-add "$local_repo_directory"/"${USER}"-repo.db.tar.gz
}

main() {
    clone_upstream
    # Having a separate script for building multiple packages in CHROOT
    # ensures sudo does not time out and ask for a password again
    sudo bash "$script_directory/min_mesa_git_aur_ccm_build.sh"
}

main
