# Dotfiles

Personal dotfiles managed with GNU Stow.

## Setup on New Machine

1. Clone this repo:
   ```bash
   git clone git@github.com:MattBitt/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Install GNU Stow:
   ```bash
   # Debian/Ubuntu/Mint
   sudo apt install stow

   # Fedora
   sudo dnf install stow
   ```

3. Deploy configs (choose what you need):
   ```bash
   stow bash    # Bash configs
   stow fish    # Fish shell configs
   stow git     # Git configs (user, email, global ignore)
   stow ssh     # SSH config
   ```

4. To remove/unstow:
   ```bash
   stow -D bash
   ```

5. Deploy the non-stow packages (see below):
   ```bash
   kde/sync.sh push
   ```

## Structure

Most directories are "stow packages" that mirror your home directory:

- `bash/` - Bash shell configs (.bashrc, .profile, etc.)
- `fish/` - Fish shell configs
- `git/` - Git configs (.gitconfig, global ignore)
- `ssh/` - SSH config (not keys!)
- `terminator/` - Terminator terminal config
- `tmux/` - tmux config

**Not stowed:**

- `kde/` - Plasma 6 configs. Copied, not symlinked — see `kde/README.md`.

## Not everything can be stowed

Apps that save config by writing a temp file and renaming it over the target
(KDE's KConfig, and others) **destroy the symlink** and leave a real file in its
place. The package then silently stops tracking, with no error and no visible
sign — `kde/` drifted ~148 lines out of date this way before it was caught.

If a package covers an app whose GUI writes its own config, prefer the copy
pattern in `kde/sync.sh` over stow. To spot a package that has already broken:

```bash
find ~/.config -maxdepth 2 -name '<file>' -not -type l
```

Anything that turns up as a real file but should be a symlink is dead.

## Notes

- SSH keys are machine-specific and NOT synced
- Fish variables are machine-specific and NOT synced
- After stowing, configs become symlinks to this repo
