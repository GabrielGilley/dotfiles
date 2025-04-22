#!/usr/bin/env bash

set -e

# === FUNCTIONS ===

detect_os() {
    uname_out="$(uname -s)"
    case "${uname_out}" in
        Linux*)     OS=Linux;;
        Darwin*)    OS=Mac;;
        *)          OS="UNKNOWN:${uname_out}"
    esac
}

detect_linux_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        echo "Cannot detect Linux distribution."
        exit 1
    fi
}

install_haskell() {
    if ! command -v ghc &> /dev/null; then
        echo "Haskell not found. Installing Haskell via ghcup..."
        curl --proto '=https' --retry 3 --tlsv1.2 -sSf https://get-ghcup.haskell.org | bash -s -- -y
        source "$HOME/.ghcup/env"
    else
        echo "Haskell already installed."
    fi
}

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL --retry 3 https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed!"
        eval "$(/opt/homebrew/bin/brew shellenv)"  # Apple Silicon
        eval "$(/usr/local/bin/brew shellenv)"     # Intel Mac
    else
        echo "Homebrew already installed."
    fi
}

install_linux_only_tools() {
    # Install eza from cargo because it's a Rust project
    if ! command -v eza &> /dev/null; then
        echo "Installing eza via cargo..."
        cargo install eza
    else
        echo "eza already installed."
    fi

    # Install Miniconda manually
    if ! command -v conda &> /dev/null; then
        echo "Installing Miniconda..."
        curl -fsSL --retry 3 https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh
        bash miniconda.sh -b -p "$HOME/miniconda"
        eval "$($HOME/miniconda/bin/conda shell.bash hook)"
        conda init
        rm -f miniconda.sh
        echo "Miniconda installed!"
    else
        echo "Miniconda already installed."
    fi

    # Install Dirbuster if available
    if ! command -v dirbuster &> /dev/null; then
        echo "Checking for dirbuster package..."
        if sudo apt list dirbuster 2>/dev/null | grep -q dirbuster; then
            sudo apt install -y dirbuster
        else
            echo "Dirbuster not available via apt. Skipping or install manually if needed."
        fi
    else
        echo "Dirbuster already installed."
    fi
}

install_linux_packages() {
    echo "Installing packages on Linux..."

    detect_linux_distro

    case "$DISTRO" in
        ubuntu|debian)
            sudo apt update
            sudo apt install -y "${LINUX_PACKAGES[@]}"
            ;;
        fedora)
            sudo dnf install -y "${LINUX_PACKAGES[@]}"
            ;;
        centos|rhel)
            sudo yum install -y "${LINUX_PACKAGES[@]}"
            ;;
        arch|manjaro)
            sudo pacman -Sy --noconfirm "${LINUX_PACKAGES[@]}"
            ;;
        opensuse*)
            sudo zypper install -y "${LINUX_PACKAGES[@]}"
            ;;
        *)
            echo "Unsupported Linux distro: $DISTRO"
            exit 1
            ;;
    esac
}

install_mac_packages() {
    echo "Installing packages on macOS..."
    install_homebrew
    brew update

    for pkg in "${PACKAGES[@]}"; do
        echo "Installing regular package: $pkg"
        brew install "$pkg" || echo "Failed to install $pkg"
    done

    for cask in "${CASKS[@]}"; do
        echo "Installing cask package: $cask"
        brew install --cask "$cask" || echo "Failed to install cask $cask"
    done
}


install_pip() {
    if ! command -v pip &> /dev/null; then
        echo "pip not found. Installing pip..."
        sudo apt update
        sudo apt install -y python3-pip
    fi
}

install_rust() {
    if ! command -v rustc &> /dev/null; then
        echo "Rust not found. Installing Rust via rustup..."
        curl --proto '=https' --retry 3 --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    else
        echo "Rust already installed."
    fi
}

update_shell_profile() {
    SHELL_PROFILE=""
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_PROFILE="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        SHELL_PROFILE="$HOME/.bashrc"
    else
        echo "Unknown shell. Please manually add environment paths."
        return
    fi

    echo "Updating $SHELL_PROFILE for Rust and Haskell paths..."

    grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' "$SHELL_PROFILE" || echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$SHELL_PROFILE"
    grep -qxF 'export PATH="$HOME/.ghcup/bin:$PATH"' "$SHELL_PROFILE" || echo 'export PATH="$HOME/.ghcup/bin:$PATH"' >> "$SHELL_PROFILE"
}

# === MAIN ===

PACKAGES=(
    # Necessary
    git    # Git
    tmux   # Background shells
    wget   # Downloads

    # QOL and Visuals
    fzf    # Fuzzy finds
    pandoc # For markdown file view (1/2)
    w3m    # for markdown file view (2/2)
    bat    # Pretty cat
    ranger # File navigation

    # Project Building
    cmake  # Makefile maker
    make   # Project builder
    podman # Containerization
    # apptainer

    # Compilers
    gcc     # C++ compiler
    openjdk # Java suite
    node    # Java script
    rust-analyzer  # for Rust language server
    
    # Debuggers
    cgdb    # GUI C++ Debugger
    gdb     # CLI C++ Debugger
    valgrind # C++ Memory leak detector

    # Security
    nmap     # Port scanning
    netcat   # Port flow
    john     # Password cracker
    # wireshark, ghidra, jadx, autopsy 
)

# Linux packages (without eza because we cargo install it)
LINUX_PACKAGES=(
    "${PACKAGES[@]/eza/}"
)

CASKS=(
    # Environment Creation
    miniconda

    # Networking
    dirbuster

    # Window management
    rectangle

    # IDE
    visual-studio-code
)

PIP_PACKAGES=(
    # Debuggers
    pudb

    # Python Professional Formatting
    black

    # Python Static Typing
    mypy

    # Data Science
    numpy
    matplotlib
    pandas
    scipy
    scikit-learn

    # AI
    torch
    transformers
    tensorflow

    # Jupyter Notebooks
    ipython
    notebook
    ipykernel
    jupyterlab
    jupyter_contrib_nbextensions
)

install_pip_packages() {
    echo "Installing Python pip packages..."
    pip install --upgrade "${PIP_PACKAGES[@]}" || echo "Failed to install some pip packages"
}

detect_os

case "$OS" in
    Mac)
        install_mac_packages
        install_rust
        install_haskell
        install_pip_packages
        update_shell_profile
        ;;
    Linux)
        install_rust
        install_linux_packages
        install_linux_only_tools
        install_haskell
        install_pip
        install_pip_packages
        update_shell_profile
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "🎉 All packages and languages installed successfully!"
echo "👉 Restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc' to finalize path updates."

