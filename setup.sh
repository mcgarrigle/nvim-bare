#!/usr/bin/bash

ARCH=$(uname -m)
[ $ARCH == aarch64 ] && ARCH=arm64

DIR="${HOME}/.local/share"
PACKAGE="nvim-linux-${ARCH}"

mkdir -p "${DIR}" && cd "${DIR}"

rm -rf "${DIR}/${PACKAGE}" "${DIR}/nvim"
curl -L https://github.com/neovim/neovim/releases/latest/download/${PACKAGE}.tar.gz|tar xz
ln -sf "${DIR}/${PACKAGE}" "${DIR}/nvim"

export PATH="${HOME}/.local/share/nvim/bin":$PATH

mkdir -p ~/.local/share/nvim/site/pack/deps/start/
cd ~/.local/share/nvim/site/pack/deps/start/

git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim

nvim --headless -c 'helptags ALL' -c 'quit'

ls -l $DIR
