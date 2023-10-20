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
--   Created: 2023/10/20 13:49:14 by madebypixel02  \___   )MMMMMP|   .'      --
--   Updated: 2023/10/20 13:49:36 by madebypixel02      `-'       `--'        --
--                                                                            --
-- ************************************************************************** --

require 'config.global'
require 'config.lazy'
require 'config.autocommands'
require 'config.keymap'
require 'config.color'

-- Vim Headers
vim.cmd('source ~/.config/nvim/lua/plugins/uoc.vim')
vim.cmd('source ~/.config/nvim/lua/plugins/42.vim')
vim.cmd('source ~/.config/nvim/lua/plugins/tux.vim')
vim.cmd('source ~/.config/nvim/lua/plugins/uc3m.vim')
vim.cmd('source ~/.config/nvim/lua/plugins/telefonica.vim')


-- Vim Mappings
vim.keymap.set("n", "m", "<Cmd>set mouse=a<CR>", {silent = true})
vim.keymap.set("n", "mm", "<Cmd>set mouse-=a<CR>", {silent = true})
vim.keymap.set("n", "b", "<Cmd>set nu<CR>", {silent = true})
vim.keymap.set("n", "bb", "<Cmd>set nonu<CR>", {silent = true})
vim.keymap.set("n", "<c-S-Right>", "<Cmd>tabn<CR>", {silent = true})
vim.keymap.set("n", "<c-S-Left>", "<Cmd>tabp<CR>", {silent = true})
vim.keymap.set("n", "<c-S-Up>", "<Cmd>tabnew<CR>", {silent = true})
vim.keymap.set("n", "<c-S-Down>", "<Cmd>tabclose<CR>", {silent = true})
