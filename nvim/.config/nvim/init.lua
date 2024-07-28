--############################################
--#  _                          _            #
--# | |    __ _ _____   ___   _(_)_ __ ___   #
--# | |   / _` |_  / | | \ \ / / | '_ ` _ \  #
--# | |__| (_| |/ /| |_| |\ V /| | | | | | | #
--# |_____\__,_/___|\__, (_)_/ |_|_| |_| |_| #
--#                 |___/                    #
--############################################

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local opts = {}

require("vim-options")
require("lazy").setup("plugins")









