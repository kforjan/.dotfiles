# dotfiles

## Install

```sh
git clone --recurse-submodules git@github.com:kforjan/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow .
```


```sh
mkdir -p ~/.local/share/zsh/plugins
for r in romkatv/powerlevel10k zsh-users/zsh-autosuggestions \
         zsh-users/zsh-syntax-highlighting zsh-users/zsh-completions Aloxaf/fzf-tab; do
  git clone --depth=1 https://github.com/$r ~/.local/share/zsh/plugins/${r##*/}
done

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm  # then prefix + I
```

## Notes

- SDDM theme: copy into `/usr/share/sddm/themes`, never symlink. SDDM runs as
  the `sddm` user, which cannot traverse a 0700 home.
