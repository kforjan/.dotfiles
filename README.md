# kforjan's dotfiles

Branch layout: `arch` (this desktop), `macos`, `main`.

## Install

```sh
git clone --recurse-submodules git@github.com:kforjan/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow .
```

`.config/nvim` is a submodule ([kforjan/config.nvim](https://github.com/kforjan/config.nvim));
`git submodule update --init` if you cloned without `--recurse-submodules`.

## What's in here

| Path | Tool |
| --- | --- |
| `.zshenv` | PATH + env for *every* zsh, interactive or not |
| `.zshrc`, `.config/zsh/` | interactive zsh, split by concern (see its README) |
| `.p10k.zsh` | powerlevel10k prompt |
| `.config/ghostty` | terminal |
| `.config/tmux` | tmux (plugins via tpm, not tracked) |
| `.config/nvim` | neovim (submodule) |
| `.config/hypr` | hyprland, hyprpaper, hyprlock |
| `.config/waybar` | status bar |
| `.config/wofi` | launcher |
| `.config/wireplumber` | audio device priority |
| `.local/share/sddm/themes/rose-pine` | login screen (SDDM) |
| `.local/scripts` | `zsh-plugins`, `install-sddm-theme` |
| `.inputrc` | readline vi mode |

## Requirements

Arch packages:

```sh
pacman -S zsh stow neovim tmux ghostty hyprland hyprpaper hyprlock hyprshot \
          waybar wofi swaync polkit-kde-agent \
          hypridle cliphist fzf zoxide bat ripgrep eza fd pkgfile \
          wl-clipboard grim slurp brightnessctl playerctl pamixer pavucontrol \
          blueman network-manager-applet nautilus \
          ttf-jetbrains-mono-nerd
```

NVIDIA: `nvidia-open-dkms nvidia-utils libva-nvidia-driver egl-wayland`.

Run `pkgfile --update` once so the zsh command-not-found handler works.

### zsh plugins

```sh
~/.local/scripts/zsh-plugins
```

Clones powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting,
zsh-completions and fzf-tab into `~/.local/share/zsh/plugins/`, or pulls them
if already present. Idempotent, so it is both the bootstrap and the updater.

To add a plugin: clone it next to the others, then add one `source` line to
`.config/zsh/20-plugins.zsh` (or `10-completion.zsh` if it ships completions,
which must be on fpath before compinit).

### tmux plugins

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Then `prefix + I` inside tmux to install the rest.

## Login screen

SDDM, not hyprlock. hyprlock only locks a session that is already running.

```sh
~/.local/scripts/install-sddm-theme
```

It copies rather than symlinks: SDDM runs as the `sddm` user, which cannot
traverse a 0700 home directory. Re-run it after editing the theme.

## Notes

- Completion cache lives in `~/.cache/zsh` and is rebuilt at most once a day.
  After installing something that ships completions, `rm ~/.cache/zsh/zcompdump-*`.
- `wireplumber.conf.d/50-sink-priority.conf` demotes the AT2020 mic's output
  sink. Without it WirePlumber ranks USB above HDMI and makes the mic the
  default output, so volume controls adjust a silent device.
- Waybar's temperature module reads `k10temp` by absolute hwmon path; that path
  is board-specific and will need changing on other hardware.
