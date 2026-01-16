# Dotfiles

Modern zsh configuration managed with [chezmoi](https://chezmoi.io).

## Stack

- **Shell**: zsh
- **Plugin Manager**: [zinit](https://github.com/zdharma-continuum/zinit) (turbo mode)
- **Prompt**: [Starship](https://starship.rs)
- **Plugins**: fast-syntax-highlighting, zsh-autosuggestions, zsh-completions

## Modern CLI Tools

| Tool | Replaces | Description |
|------|----------|-------------|
| [eza](https://github.com/eza-community/eza) | ls | Modern ls with git integration |
| [bat](https://github.com/sharkdp/bat) | cat | Syntax highlighting |
| [fd](https://github.com/sharkdp/fd) | find | Simpler, faster find |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | grep | Faster grep |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | cd | Smarter directory jumping |
| [fzf](https://github.com/junegunn/fzf) | - | Fuzzy finder |

## Installation

### New Machine

1. Install dependencies (Ubuntu/Debian):
   ```bash
   # Run the install script
   curl -fsSL <your-repo-url>/raw/main/install.sh | bash
   # Or clone and run locally
   git clone <your-repo-url> ~/dotfiles-temp
   ~/dotfiles-temp/install.sh
   ```

2. Apply dotfiles with chezmoi:
   ```bash
   chezmoi init --apply <your-repo-url>
   ```

3. Set zsh as default shell:
   ```bash
   chsh -s $(which zsh)
   ```

4. Log out and back in.

### Updating

```bash
chezmoi update
```

## Structure

```
.
├── dot_zshrc              # Zsh configuration
├── dot_config/
│   └── starship.toml      # Starship prompt config
├── .chezmoiscripts/       # Scripts run by chezmoi
├── .chezmoi.toml.tmpl     # Chezmoi config template
└── install.sh             # Tool installation script
```
