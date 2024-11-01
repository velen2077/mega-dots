![mega-dots](assets/images/mega-dots.png)

# mega-dots

My Flaked-out mega-dots config for managing systems and homes using Nix, Home Manager and a sprinkling of Snowfall Lib.

## Introduction

This is my personal system configuration repo that I use to build systems and homes in conjunction with Nix, Home Manager and Snowfall Lib. I started out this journey based on sheer curiosity and a desire to have a somewhat declaritive composition to system management (I distro hop - a lot). Some searching online lead me down the garden path that is Nix, and here I am. Down the rabbit hole.

I am not an expert in Nix, NixOS, Home Manager or Snowfall Lib. Nor am I a developer. Outside of my consultancy job (in a technical field so not completely in the dark), I'm a tinkerer. I'd been feeling a little burnt out and in need of something to learn in my downtime, and this project came along at the perfect time, and has genuinely brought some fun back in to computing for me. Just like the days of old, going to the local monthly computer market and picking up a fresh copy of a new Linux distro on a wad of floppies and taking it for a spin.

## Usage

This configuration has two primary entry-points. System and Home Manager. At the moment, I am a single user managing a single machine (though expect this to grow).

| System | Description | OS | CPU | GPU |
|---|---|---|---|---|
| endgame | My personal computer | NixOS | AMD Ryzen 7800X3D | nVidia 4070 Ti |

I have a single user that I manage through Home Manager (velen2077). You may add additional users or rename mine to inherit my existing settings - though don't forget to change my hashedPassword to something of your own otherwise you won't be able to log in.

### File structure

```
.
├── assets
│   ├── avatar
│   ├── images
│   └── wallpaper
├── flake.lock
├── flake.nix
├── homes
│   └── x86_64-linux
│       └── velen2077@endgame
├── justfile
├── lib
│   └── default.nix
├── modules
│   ├── home
│   │   ├── apps
│   │   ├── cli
│   │   └── tools
│   └── nixos
│       ├── desktop
│       │   └── gnome
│       ├── gaming
│       ├── hardware
│       │   ├── audio
│       │   ├── networking
│       │   └── nvidia
│       ├── packages
│       │   ├── basics
│       │   └── development
│       └── system
├── README.md
└── systems
    └── x86_64-linux
        └── endgame
```

## mega-thanks

I learn by doing. None of this would be possible without the copious ammounts of developers and repos that share their content freely for others like me to disect and study. There are many, but to name a few - shout outs go to:

- Nvim - https://github.com/Nvim (https://github.com/Nvim/snowfall)
- mtrsk - https://github.com/mtrsk (https://github.com/mtrsk/nixos-config)
- runarsf - https://github.com/runarsf (https://github.com/runarsf/dotfiles)
- librephoenix - https://github.com/librephoenix (https://github.com/librephoenix/nixos-config)
- frost-phoenix - https://github.com/Frost-Phoenix (https://github.com/Frost-Phoenix/nixos-config)