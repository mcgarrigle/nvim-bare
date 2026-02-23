#!/usr/bin/bash

ARCH=$(uname -m)
[ $ARCH == aarch64 ] && ARCH=arm64

DIR="~/.local/share"
RELEASE="nvim-linux-${ARCH}"

function make-dir {
  mkdir -p "$1" && cd "$1"
}

function setup_neovim {
  make-dir "${DIR}"
	rm -rf "${DIR}/${RELEASE}" "${DIR}/nvim"
	curl -L https://github.com/neovim/neovim/releases/latest/download/${RELEASE}.tar.gz | tar xz
	ln -sf "${DIR}/${RELEASE}" "${DIR}/nvim"
}

function setup_init {
	make-dir "~/.local/share/nvim/site/pack/deps/start/"
	git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim
}

function setup_update {
  export PATH="${HOME}/.local/share/nvim/bin":$PATH
  nvim --headless -c 'helptags ALL' -c 'quit'
}

function setup_install {
	setup_neovim
	setup_init
	setup_update
}

setup_${1:-install}
