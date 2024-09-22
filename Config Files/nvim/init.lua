-- ************************************************************************** --
--                                                                            --
--                                                          _nnnn_            --
--                                                         dGGGGMMb           --
--                                                        @p~qp~~qMb          --
--                                                        M|@||@) M|          --
--                                                        @,----.JM|          --
--                                                       JS^\__/  qKL         --
--                                                      dZP        qKRb       --
--                                                     dZP          qKKb      --
--                                                    fZP            SMMb     --
--                                                    HZM            MMMM     --
--   init.lua                                         FqM            MMMM     --
--                                                  __| `.        |\dS'qML    --
--   By: madebypixel02 <madebypixel02@proton.me>    |    `.       | `' \Zq    --
--                                                  _)      .___.,|     .'    --
--   Created: 2024/09/22 22:22:24 by madebypixel02  \___   )MMMMMP|   .'      --
--   Updated: 2024/09/22 22:23:05 by madebypixel02      `-'       `--'        --
--                                                                            --
-- ************************************************************************** --

-- NOTE: Throughout this config, some plugins are
-- disabled by default. This is because I don't use
-- them on a daily basis, but I still want to keep
-- them around as examples.
-- You can enable them by changing `enabled = false`
-- to `enabled = true` in the respective plugin spec.
-- Some of these also have the
-- PERF: (performance) comment, which
-- indicates that I found them to slow down the config.
-- (may be outdated with newer versions of the plugins,
-- check for yourself if you're interested in using them)

require 'config.global'
require 'config.lazy'
require 'config.autocommands'
require 'config.redir'

-- Vim Headers
vim.cmd('source ~/Distrobox-Quick-Setup/Config Files/nvim/Headers/uoc.vim')
vim.cmd('source ~/Distrobox-Quick-Setup/Config Files/nvim/Headers/42.vim')
vim.cmd('source ~/Distrobox-Quick-Setup/Config Files/nvim/Headers/tux.vim')
vim.cmd('source ~/Distrobox-Quick-Setup/Config Files/nvim/Headers/uc3m.vim')
vim.cmd('source ~/Distrobox-Quick-Setup/Config Files/nvim/Headers/telefonica.vim')

-- Vim Mappings
vim.keymap.set("n", "<c-S-Right>", "<Cmd>tabn<CR>", {silent = true})
vim.keymap.set("n", "<c-S-Left>", "<Cmd>tabp<CR>", {silent = true})
vim.keymap.set("n", "<c-S-Up>", "<Cmd>tabnew<CR>", {silent = true})
vim.keymap.set("n", "<c-S-Down>", "<Cmd>tabclose<CR>", {silent = true})

-- Configs
vim.opt.showcmd = true
vim.opt.mouse = "a"
vim.opt.laststatus = 2
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 999
vim.opt.relativenumber = true
vim.opt.encoding = "utf-8"
