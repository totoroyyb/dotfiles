# dotfiles

Personal dev-environment setup for a fresh Linux server, layered across three tools:

| Layer | Owns | Source of truth |
|-------|------|-----------------|
| **[chezmoi](https://chezmoi.io)** | dotfiles & config: shell rc, git, nvim, lazygit, bat, tmux, p10k, plus oh-my-zsh + plugins | `dot_*`, `.chezmoiexternal.toml` |
| **[mise](https://mise.jdx.dev)** | dev tools & language toolchains (prebuilt binaries) | `dot_config/mise/config.toml` |
| **[Nix](https://nixos.org)** (via mise `nix:` backend) | system packages with no mise binary (`unzip`, `xclip`, future OS deps) | `run_onchange_after_mise-nix-setup.sh` |

No per-package `sudo apt`: system packages come from nixpkgs, and the only privileged step is the one-time Nix install.

## Prerequisites

Base OS packages the repo does **not** manage. `git`/`curl` are usually already present; `zsh` often isn't (the configs are zsh-centric):

```bash
sudo apt update && sudo apt install -y git curl zsh
```

Everything else — mise, chezmoi, dev tools, system packages — is bootstrapped below.

## Quick start

```bash
# 1. mise — installs to ~/.local/bin (no sudo). MUST precede chezmoi apply.
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

# 2. chezmoi — install, then clone + apply this repo
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" init --apply totoroyyb

# 3. Fresh shell so PATH picks up mise + nix and the rc files load
exec zsh

# 4. Install all dev tools + nix system packages
mise install

# 5. GitHub auth + make zsh the login shell
mise run gh-auth
chsh -s "$(command -v zsh)"
```

Re-login (or `exec zsh`) afterward to get the full powerlevel10k prompt, completions, and shims.

## What `chezmoi apply` does

1. **Fetches externals** (`.chezmoiexternal.toml`): oh-my-zsh, powerlevel10k, zsh-syntax-highlighting, fzf-tab.
2. **Writes configs**: `.zshrc`, `.shellrc`, `.envrc`, `.gitconfig`, `.tmux.conf.local`, and `~/.config/{mise,nvim,lazygit,bat,zellij}/…`.
3. **Runs scripts**:
   - `run_once_before_init-tmux.sh` — clones the gpakosz `.tmux` framework.
   - `run_once_after_env-setup.sh` — exports `DISPLAY` into the rc files.
   - `run_once_after_git-setup.sh` — sets git user name/email.
   - `run_onchange_after_mise-nix-setup.sh` — the Nix bootstrap (below).

## The Nix backend (system packages)

`run_onchange_after_mise-nix-setup.sh` adapts to the host's privileges:

| Situation | Behavior |
|-----------|----------|
| Nix already installed | Enable flakes, register the `mise-nix` backend plugin, declare packages |
| No Nix, sudo available | Install Nix (Determinate installer), then as above |
| No Nix, no sudo | Print the packages it can't install and continue — nothing breaks |

The list lives in the `NIX_PACKAGES=(...)` array at the top of that script. It writes a `~/.config/mise/conf.d/nix-system.toml` fragment (auto-merged by mise) so `mise install` pulls those packages through the `nix:` backend.

## Day-to-day

```bash
# Update everything from the remote
chezmoi update                                   # git pull + apply

# Add / change a dev tool
chezmoi edit --apply ~/.config/mise/config.toml  # edit [tools], then:
mise install

# Add a system (Nix) package
chezmoi cd                                        # into the source repo
$EDITOR run_onchange_after_mise-nix-setup.sh      # extend NIX_PACKAGES=(...)
exit
chezmoi apply && mise install                     # onchange re-runs -> fragment rewritten

# Re-authenticate GitHub
mise run gh-auth
```

## Gotchas

- **Install mise before `chezmoi apply`.** The Nix bootstrap needs `mise` on PATH; if it's missing it skips, and won't auto-retry (it's a `run_onchange_` script).
- **Open a fresh shell before `mise install`.** Nix is installed mid-apply but only lands on PATH in new shells (via `.envrc`); otherwise `nix:` packages can't resolve. `exec zsh` handles it — or inline: `. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && mise install`.
- **Private repo?** `chezmoi init totoroyyb` uses https; for a private repo, set up SSH or a token first.

## Installed tools

- **Dev tools (mise):** rust, node (lts), bun, neovim, lazygit, delta, gh, fzf, ripgrep, fd, eza, zoxide, zellij, bat, tlrc, uv.
- **System packages (Nix):** unzip, xclip.

## Retired scripts

Legacy installers are kept for reference but renamed with a leading `.` so chezmoi ignores them:

| File | Replaced by |
|------|-------------|
| `.deprecated_run_once_before_install-packages.sh` | mise `[tools]` + Nix backend |
| `.deprecated_run_once_after_setup-editor.sh` | mise (`neovim`, `lazygit`) |
| `.deprecated_run_once_before_github-auth.sh` | mise (`gh`) + `mise run gh-auth` |
