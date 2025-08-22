# LeeDat03's Dotfiles

Set up your development environment on **Windows** and **Linux** using these configuration files.

---

## Prerequisites 📋

Make sure you have the following installed:

- **Font:** [MonaspiceAr Nerd Font](https://www.nerdfonts.com/) (or any Nerd Font)
- **Shell:**
  - Windows: PowerShell (`pwsh`)
  - Linux: zsh
- **Terminal:** WezTerm, Kitty
- **Prompt:** Oh My Posh
- **Editor:** Neovim

---

## Installation Guide 🚀

### 1. Install the Font 🖋️

Icons and symbols in the prompt require a Nerd Font.

1. Download **MonaspiceAr Nerd Font** from the [Nerd Fonts website](https://www.nerdfonts.com/).
2. Install the font on your system.
3. Set it as your default font in your terminal emulator (e.g., WezTerm, Windows Terminal).

---

### 2. Clone and Link Configuration Files 📂

#### Clone the repository

```bash
git clone https://github.com/LeeDat03/.dotfiles.git
```

#### Create symbolic links

**On Windows:**  
Open PowerShell as Administrator and run:

```powershell
# Link WezTerm and Neovim configurations
mklink "C:\Users\<your-username>\.wezterm.lua" "\path\to\.dotfiles\wezterm.lua"
mklink "C:\Users\<your-username>\AppData\Local\nvim" "\path\to\.dotfiles\nvim"
```

**On Linux:**  
Run in your terminal:

```bash
# Link zsh, WezTerm, Kitty, and Neovim configurations
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/wezterm.lua ~/.wezterm.lua
ln -s ~/.dotfiles/kitty ~/.config/kitty
ln -s ~/.dotfiles/nvim ~/.config/nvim
```

---

### 3. Set Up Oh My Posh Prompt ✨

**On Windows (PowerShell):**

Open your PowerShell profile for editing:

```powershell
notepad $PROFILE
```

Add this line to the file:

```powershell
oh-my-posh init pwsh --config 'path\to\.dotfiles\oh-my-posh\hul10-custom.json' | Invoke-Expression
```

**On Linux (zsh):**

Your `.zshrc` should already contain the necessary line:

```bash
eval "$(oh-my-posh init zsh --config ~/path/to/.dotfiles/oh-my-posh/hul10-custom.json)"
```
