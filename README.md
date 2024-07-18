this is just no my nvim, this is my whole config in computer
# custom font 
from the infor that i have found on internet, nerd font is the patched font, but i dont know patched font mean, just update origin font with a lot of features and icons ? if so, then patched font is updated of origin font and called font with more features - but called patched font, and origin font is just the font with less features than.
so i consider font and patched font is the same, patched font is such like v2, v3 and more of origin font
there 2 fonts that suitable for me
- ubuntu mono
- cascadia mono, https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode/Regular
## mint linux
- download font file with .tff extension, search [nerdfont](https://www.nerdfonts.com/font-downloads) to download
- copy all file *.tff to font custom to specific system folder linux ```sudo mv *.ttf ~/.local/share/fonts```
- go to setting, search font application to set added font, note (hình như không cần cài nerdfont thì phải)
  - "Monospace font" for terminal
  - "Desktop font" for font outside desktop
  - "Default font" for in which set default font such like: chrome,..
## window
- download font file and click to font downloaded to install
- in terminal -> setting -> which terminal i want -> apperance -> font face -> font i want
- then restart 
# custom vim - using neovim
 requirement:
- install node v16
- install lastest nvim: recommend using snap, not using ppa
- install fd: sudo apt install fd-find
- install rg: sudo apt-get install ripgrep
- install dlv for golang debug: 
```
# Install the latest release:
$ go install github.com/go-delve/delve/cmd/dlv@latest
```
- some errors happen
  - prettier not found: npm install -g prettier
  - install lsp not work: then MasonInstall --force name_of_package
  - err with debug package
    - Golang
        - check terminal "which dlv", if display path then ok, nothing is not set path dlv in golang bin not in system path
          - set path in ~/.bashrc:
            ```
              export GOPATH="$HOME/go"
              export GOBIN="$GOPATH/bin"
              export PATH="$PATH:$GOBIN"
            ```
            export PATH="$PATH:$GOBIN" mean append path GOBIN in PATH
            then run "source ~/.bashrc" to update
- file lua located in ~/.config/nvim
- install packages in nvim using packer management
  - :PackerInstall
  - :PackerCompile
  - :PackerSync
# keep remember install 
  - 
## map key
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
## check bug: :checkhealth
# custom vscode
## in open_keyboard_shortcut (JSON)
```
// Place your key bindings in this file to override the defaults
[
    {
        "key": "ctrl+g",
        "command": "editor.action.goToImplementation",
        "when": "editorHasImplementationProvider && editorTextFocus"
    },
    {
        "key": "ctrl+h",
        "command": "workbench.action.navigateLeft"
    },
    {
        "key": "ctrl+l",
        "command": "workbench.action.navigateRight"
    },
    {
        "key": "ctrl+k",
        "command": "workbench.action.navigateUp"
    },
    {
        "key": "ctrl+j",
        "command": "workbench.action.navigateDown"
    }
]
```
## in open_user_settings (JSON)
```
{
    "vim.insertModeKeyBindings": [
        {
            "before": ["j", "k"],
            "after": ["<Esc>"]
        }
    ],
    "files.autoSave": "afterDelay",
    "git.enableSmartCommit": true,
    "security.workspace.trust.untrustedFiles": "open",
    "workbench.colorTheme": "mojo",
    "cloudcode.duetAI.project": "vantien-703b7",
    "go.toolsManagement.autoUpdate": true
    
}
```
# custom pycharm
- install neovim + config in ~/.ideavimrc "imap jk <Esc>"

