local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")

if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("Mofiqul/dracula.nvim")

  -- lua functions
  use("nvim-lua/plenary.nvim")
  use('nvim-lualine/lualine.nvim')
  
  
  use("christoomey/vim-tmux-navigator")
  use("szw/vim-maximizer")

  use("tpope/vim-surround")
  use("vim-scripts/ReplaceWithRegister")
  
  --comment with gc
  use("numToStr/Comment.nvim")
  use("nvim-tree/nvim-web-devicons")


  -- file explorer
  use ("nvim-tree/nvim-tree.lua")

  -- Telescope and opt dependencies. 
  use("nvim-telescope/telescope.nvim")
  use("BurntSushi/ripgrep")
  use("sharkdp/fd")
  use("nvim-treesitter/nvim-treesitter")

  -- Language parsers, linters
  use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate"
  }

  if packer_bootstrap then
    require("packer").sync()
  end

end)
