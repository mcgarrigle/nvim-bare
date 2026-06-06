#!/usr/bin/bash

function make-dir {
  echo "// make dir $1"
  mkdir -p "$1" && cd "$1"
}

function setup_neovim {
  make-dir "${LOCATION}"
  rm -rf "${LOCATION}/${RELEASE}" "${LOCATION}/nvim"
  curl -L $URL | tar xz
  ln -sf "${LOCATION}/${RELEASE}" "${LOCATION}/nvim"
}

function setup_plugins {
  nvim --headless -c 'helptags ALL' -c 'quit'
  echo
}

function setup_install {
  setup_neovim
  setup_plugins
}

# -------------------------------------

ARCH=$(uname -m)
[ $ARCH == aarch64 ] && ARCH=arm64

LOCATION="${HOME}/.local/share"
RELEASE="nvim-linux-${ARCH}"
URL="https://github.com/neovim/neovim/releases/latest/download/${RELEASE}.tar.gz"

export PATH="${LOCATION}/nvim/bin":$PATH

# -------------------------------------

setup_${1:-install}
