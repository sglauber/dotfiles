### Hi there! :octocat: 
Those are my dotfiles, I'm trying to keep it simple, and I hope you find something useful here. ^^

Here are some details about:

<img src="./docs/assets/corgi.gif" alt="" align="right" width="350px">

- **WM**                           : [hyprland](https://hyprland.org/) :art:
- **Shell**                        : [zsh](https://wiki.archlinux.org/index.php/zsh) :shell:
- **Terminal**                     : [alacritty](https://codeberg.org/dnkl/foot/wiki) 🦶
- **Panel**                        : [waybar](https://github.com/Alexays/Waybar) :shaved_ice:
- **Notify Daemon**                : [dunst](https://wiki.archlinux.org/index.php/Dunst) 🔔 
- **Application Launcher**         : [rofi](https://github.com/davatorium/rofi) :rocket:
- **File Manager**                 : [lf](https://github.com/gokcehan/lf) 📂 minimal file manager!

<hr>

#### ⚠️ WARNING - These are personal configuration files. Please take a look at the repository and scripts so you can be sure about what everything is doing.

## :arrow_down: Download

For now, it's **mandatory** to clone this repo and copy the wanted files to `~/.config` assuming this is where your `$XDG_CONFIG_HOME` is located.

```shell
mv -r ~/.config ~/.config_bak && git clone https://github.com/sglauber/dotfiles.git ~/.config
```

## :gear: Installation
You can find the needed packages on the packages dir.

### Other tools that I use

- [exa](https://the.exa.website/) as a replacement for `ls`
- [bat](https://github.com/sharkdp/bat) instead of `cat`
- [jq](https://jqlang.github.io/jq/) `JSON` cli processor
- [delta](https://github.com/dandavison/delta): `diff` with style
- [fd](https://github.com/sharkdp/fd) as a `find` alternative
- [ripgrep](https://github.com/BurntSushi/ripgrep) to kill old `grep`
- [fzf](https://github.com/junegunn/fzf) the fuzzy finder

### 📦 Installing needed packages and general configurations:

#### Package installation is ONLY supported for **Arch Linux** based systems (installation via pacman or another aur helper). I recommend using yay.

Execute:

```shell
yay -S - < <FILE_NAME> --noconfirm
```

where 
```<FILE_NAME>```
might be:

```
base_packages        - installs needed packages using aur helper
```

### TODO :smile:
- :x: **script** to **automatically install** needed packages and configs
- :x: **bare repo strategy** [Dotfiles: Store in a Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles)

## :handshake: Thanks

Inspiration from everywhere. Feel free to poke around!

_I use Arch, but you can use any distro you'd like._ :)
