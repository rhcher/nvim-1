local bind = require "keymap.bind"
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
  -- Vim map
  ["n|<leader>bk"] = map_cr("bdelete"):with_noremap():with_silent(),
  ["n|<leader>bs"] = map_cu("write"):with_noremap(),
  ["n|Y"] = map_cmd "y$",
  ["n|]w"] = map_cu("WhitespaceNext"):with_noremap(),
  ["n|[w"] = map_cu("WhitespacePrev"):with_noremap(),
  ["n|]b"] = map_cu("bn"):with_noremap(),
  ["n|[b"] = map_cu("bp"):with_noremap(),
  ["n|<Space>cw"] = map_cu([[silent! keeppatterns %substitute/\s\+$//e]])
    :with_noremap()
    :with_silent(),
  ["n|<A-h>"] = map_cmd("<C-w>h"):with_noremap(),
  ["n|<A-l>"] = map_cmd("<C-w>l"):with_noremap(),
  ["n|<A-j>"] = map_cmd("<C-w>j"):with_noremap(),
  ["n|<A-k>"] = map_cmd("<C-w>k"):with_noremap(),
  ["n|<A-]>"] = map_cr("vertical resize -5"):with_silent(),
  ["n|<A-[>"] = map_cr("vertical resize +5"):with_silent(),
  ["n|<C-q>"] = map_cmd ":wq<CR>",
  ["n|<Leader>ss"] = map_cu("SessionSave"):with_noremap(),
  ["n|<Leader>sl"] = map_cu("SessionLoad"):with_noremap(),
  -- Insert
  ["i|<C-w>"] = map_cmd("<C-[>diwa"):with_noremap(),
  ["i|<C-d>"] = map_cmd("<Del>"):with_noremap(),
  ["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap(),
  ["i|<C-b>"] = map_cmd("<Left>"):with_noremap(),
  ["i|<C-f>"] = map_cmd("<Right>"):with_noremap(),
  ["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap(),
  ["i|<C-j>"] = map_cmd("<C-o>o"):with_noremap(),
  ["i|<C-k>"] = map_cmd("<C-o>O"):with_noremap(),
  ["i|<C-s>"] = map_cmd "<Esc>:w<CR>",
  ["i|<C-q>"] = map_cmd "<Esc>:wq<CR>",
  ["i|<C-e>"] = map_cmd([[pumvisible() ? "\<C-e>" : "\<End>"]])
    :with_noremap()
    :with_expr(),
  ["i|jj"] = map_cmd("<Esc>"):with_noremap(),
  ["i|<C-l>"] = map_cmd("<Plug>(vsnip-expand-or-jump)"):with_silent(),
  ["s|<C-l>"] = map_cmd("<Plug>(vsnip-expand-or-jump)"):with_silent(),
  ["i|<C-h>"] = map_cmd("<Plug>(vsnip-jump-prev)"):with_silent(),
  ["i|<M-h>"] = map_cmd([[<C-\><C-n><C-w>h]]):with_silent(),
  ["i|<M-j>"] = map_cmd([[<C-\><C-n><C-w>j]]):with_silent(),
  ["i|<M-k>"] = map_cmd([[<C-\><C-n><C-w>k]]):with_silent(),
  ["i|<M-l>"] = map_cmd([[<C-\><C-n><C-w>l]]):with_silent(),
  -- termianl
  ["t|<M-h>"] = map_cmd([[<C-\><C-n><C-w>h]]):with_silent(),
  ["t|<M-j>"] = map_cmd([[<C-\><C-n><C-w>j]]):with_silent(),
  ["t|<M-k>"] = map_cmd([[<C-\><C-n><C-w>k]]):with_silent(),
  ["t|<M-l>"] = map_cmd([[<C-\><C-n><C-w>l]]):with_silent(),
  ["t|<esc>"] = map_cmd([[<C-\><C-n>]]):with_silent(),
  -- command line
  ["c|<C-b>"] = map_cmd("<Left>"):with_noremap(),
  ["c|<C-f>"] = map_cmd("<Right>"):with_noremap(),
  ["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
  ["c|<C-e>"] = map_cmd("<End>"):with_noremap(),
  ["c|<C-d>"] = map_cmd("<Del>"):with_noremap(),
  ["c|<C-h>"] = map_cmd("<BS>"):with_noremap(),
  ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
}

bind.nvim_load_mapping(def_map)
