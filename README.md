# vimko

```
                               ___           ___           ___     
      ___        ___          /__/\         /__/|         /  /\    
     /__/\      /  /\        |  |::\       |  |:|        /  /::\   
     \  \:\    /  /:/        |  |:|:\      |  |:|       /  /:/\:\  
      \  \:\  /__/::\      __|__|:|\:\   __|  |:|      /  /:/  \:\ 
  ___  \__\:\ \__\/\:\__  /__/::::| \:\ /__/\_|:|____ /__/:/ \__\:\
 /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/ \  \:\/:::::/ \  \:\ /  /:/
 \  \:\|  |:|     \__\::/  \  \:\        \  \::/~~~~   \  \:\  /:/ 
  \  \:\__|:|     /__/:/    \  \:\        \  \:\        \  \:\/:/  
   \__\::::/      \__\/      \  \:\        \  \:\        \  \::/   
       ~~~~                   \__\/         \__\/         \__\/    
```

A personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim >= 0.11
- [Nerd Font](https://www.nerdfonts.com/) — for icons
- `curl` — for the dashboard dad jokes
- `ripgrep` — for Telescope live grep
- `git`

## Plugins

| Plugin | Description |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason](https://github.com/mason-org/mason.nvim) | LSP |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocomplete |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax / indent / folds |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer (edit filesystem like a buffer) |
| [mini.ai](https://github.com/echasnovski/mini.ai) | Extended text objects |
| [mini.surround](https://github.com/echasnovski/mini.surround) | Surround motions |
| [mini.move](https://github.com/echasnovski/mini.move) | Move lines and selections |
| [mini.animate](https://github.com/echasnovski/mini.animate) | Smooth scroll / cursor animations |
| [mini.cursorword](https://github.com/echasnovski/mini.cursorword) | Highlight word under cursor |
| [mini.cmdline](https://github.com/echasnovski/mini.cmdline) | Command line UI |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight and navigate TODO/FIXME/NOTE |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) + [themery](https://github.com/zaldih/themery.nvim) | Themes |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification UI |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard with random dad jokes |
| [auto-session](https://github.com/rmagatti/auto-session) | Session management |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap hints |
| [markview.nvim](https://github.com/OXY2DEV/markview.nvim) | Inline markdown and LaTeX preview |

## Installation

```sh
git clone https://github.com/MakoBoko/vimko.git ~/.config/nvim
nvim
```

Lazy will bootstrap itself and install all plugins on first launch.
