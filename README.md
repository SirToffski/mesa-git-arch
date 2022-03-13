# mesa-git-arch

A script to build `mesa-git`, `lib32-mesa-git` and `xf86-video-amdgpu-git` AUR packages in a clean chroot and add them to a local repository.

# Usage

First, read over the script and make any modifications required for your use-case. 

There are two files:
* `min_mesa_git_aur_ccm.sh` - clones AUR repositories, prepares local repository, launches the build script
* `min_mesa_git_aur_ccm_build.sh` - the build script. It exists as a separate file for conveniece. This way it can be run via `sudo` - making sure `sudo` password does not time out during a long build process.

In my use case:
```bash
$ git clone https://github.com/SirToffski/mesa-git-arch.git
$ cd mesa-git-arch
$ bash min_mesa_git_aur_ccm.sh
```

# Requirements

The script uses `clean-chroot-manager`(1).

1. https://github.com/graysky2/clean-chroot-manager

In addition, there are two separate `makepkg.conf` files used. 

* `/usr/share/devtools/makepkg-x86_64.conf` is used to build:
  * `python-sphinx-automodapi`
  * `llvm-minimal-git`
  * `lib32-llvm-minimal-git`


* `/home/$USER/makepkg-x86_64_O3.conf` is used to build:
  * `mesa-git`
  * `lib32-mesa-git`
  * `xf86-video-amdgpu-git`

```diff
--- a/usr/share/devtools/makepkg-x86_64.conf
+++ b/home/$USER/makepkg-x86_64_O3.conf
@@ -40,7 +40,7 @@ CHOST="x86_64-pc-linux-gnu"
 
 #-- Compiler and Linker Flags
 #CPPFLAGS=""
-CFLAGS="-march=x86-64 -mtune=generic -O2 -pipe -fno-plt -fexceptions \
+CFLAGS="-march=ivybridge -O3 -pipe -fno-plt -fexceptions \
         -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security \
         -fstack-clash-protection -fcf-protection"
 CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
@@ -94,7 +94,7 @@ BUILDENV=(!distcc color !ccache check !sign)
 #-- debug:      Add debugging flags as specified in DEBUG_* variables
 #-- lto:        Add compile flags for building with link time optimization
 #
-OPTIONS=(strip docs !libtool !staticlibs emptydirs zipman purge !debug !lto)
+OPTIONS=(strip docs !libtool !staticlibs emptydirs zipman purge !debug lto)
 
 #-- File integrity checks to use. Valid: md5, sha1, sha224, sha256, sha384, sha512, b2
 INTEGRITY_CHECK=(sha256)
@@ -160,3 +160,4 @@ SRCEXT='.src.tar.gz'
 #-- Command used to run pacman as root, instead of trying sudo and su
 #PACMAN_AUTH=()
 # vim: set ft=sh ts=2 sw=2 et:
```

Using `-O3` is not usually recommended, it is done for testing purposes only. Instead, `-O2` is more suitable for daily use.

Remaining packages use standard `/usr/share/devtools/makepkg-x86_64.conf`.

For more info in safe CFLAGS, Gentoo wiki is a good source: https://wiki.gentoo.org/wiki/Safe_CFLAGS#Manual
