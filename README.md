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

## Structure

Each directory is a "stow package" that mirrors your home directory:

- `bash/` - Bash shell configs (.bashrc, .profile, etc.)
- `fish/` - Fish shell configs
- `git/` - Git configs (.gitconfig, global ignore)
- `ssh/` - SSH config (not keys!)

## Notes

- SSH keys are machine-specific and NOT synced
- Fish variables are machine-specific and NOT synced
- After stowing, configs become symlinks to this repo
