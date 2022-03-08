# mesa-git-arch

A script to build `mesa-git`, `lib32-mesa-git` and `xf86-video-amdgpu-git` AUR packages in a clean chroot and add them to a local repository.

# Requirements

The script uses `clean-chroot-manager`(1).

1. https://github.com/graysky2/clean-chroot-manager

In addition, there are two separate `makepkg.conf` files used. `mesa-git`, `lib32-mesa-git`, and `xf86-video-amdgpu-git` packages are built with optimizations for Intel IvyBridge CPU.

```bash
#-- Compiler and Linker Flags
#CPPFLAGS=""
CFLAGS="-march=ivybridge -O3 -pipe -fno-plt -fexceptions \
        -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security \
        -fstack-clash-protection -fcf-protection"
CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"
LTOFLAGS="-flto=auto"
#RUSTFLAGS="-C opt-level=2"
#-- Make Flags: change this for DistCC/SMP systems
#MAKEFLAGS="-j2"
#-- Debugging flags
DEBUG_CFLAGS="-g"
DEBUG_CXXFLAGS="$DEBUG_CFLAGS"
#DEBUG_RUSTFLAGS="-C debuginfo=2"
```

Using `-O3` is not usually recommended, it is done for testing purposes only. Instead, `-O2` is more suitable for daily use.

Remaining packages use standard `/usr/share/devtools/makepkg-x86_64.conf`.
