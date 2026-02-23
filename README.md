# nvim

Install nvim:
```
git clone https://github.com/mcgarrigle/nvim.git ~/.config/nvim
~/.config/nvim/setup.sh

# add to .bash_profile
export PATH="${HOME}/.local/share/nvim/bin":$PATH

```

Update Mini.Deps plugins:
```
cd ~/.local/share/nvim/site/pack/deps/start/                                      
git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim     
git clone --filter=blob:none https://github.com/akinsho/toggleterm.nvim                    
nvim --headless -c 'helptags ALL' -c 'quit'   
```
