this is just no my nvim, this is my whole config in computer
# custom font (mint linux)
- download font file with .tff extension, search [nerdfont](https://www.nerdfonts.com/font-downloads) to download
- copy all file *.tff to font custom to specific system folder linux ```sudo mv *.ttf ~/.local/share/fonts```
- go to setting, search font application to set added font, note (hình như không cần cài nerdfont thì phải)
  - "Monospace font" for terminal
  - "Desktop font" for font outside desktop
  - "Default font" for in which set default font such like: chrome,..
# custom vim - using neovim
 requirement:
 - install node v16
- install lastest nvim: recommend using snap, not using ppa
- install fd: sudo apt install fd-find
- install rg: sudo apt-get install ripgrep
- some errors happen
  - prettier not found: npm install -g prettier
  - install lsp not work: then MasonInstall --force name_of_package
- file lua located in ~/.config/nvim
- install packages in nvim using packer management
  - :PackerInstall
  - :PackerCompile
  - :PackerSync
# custom vscode
# custom pycharm
- install neovim + config in ~/.ideavimrc "imap jk <Esc>"
# map key
  - terminator
    - ctrl + tab: go to next tab
    - ctrl + shift + tab: go to previous tab
    - ctrl + w: close current tab
 - nvim
   <leader> assign to space
    - <leader> sv: split window vertically
    - <leader> sh: split window horizontally
    - <leader> se: make split windows equal width
    - <leader> sx: close current split window
    - <leader> ff: telescope find_files
    - <leader> fs: telescope live_grep
    - <leader> fc: telescope grep_string
    - <leader> fb: telescope buffers
    - <leader> fh: telescope help_tags
    - ctrl + t: open terminal
