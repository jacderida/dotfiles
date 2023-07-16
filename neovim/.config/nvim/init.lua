-- [[ leader must be set before any plugins are loaded ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ install the lazy plugin manager ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ install plugins with lazy ]]
require('lazy').setup({
  'folke/which-key.nvim',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'j-hui/fidget.nvim',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  },
  'j-hui/fidget.nvim',
  'L3MON4D3/LuaSnip',
  'lewis6991/gitsigns.nvim',
  {
    'lunarvim/horizon.nvim',
    lazy = false, -- load during startup for main colorscheme
    priority = 1000, -- load before all other plugins
    config = function()
      vim.cmd([[
        colorscheme horizon
      ]])
    end,
  },
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  'nvim-lualine/lualine.nvim',
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'numToStr/Comment.nvim',
  {
    'preservim/vim-indent-guides',
    config = function()
      vim.cmd([[
        IndentGuidesEnable
        let g:indent_guides_guide_size = 1
      ]])
    end,
  },
  'saadparwaiz1/cmp_luasnip',
  'simrat39/rust-tools.nvim',
  'tpope/vim-endwise',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tummetott/unimpaired.nvim',
  'windwp/nvim-autopairs',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim'
}, {})

-- [[ highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ format on save ]]
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
  pattern = '*',
})

-- [[ explicitly load and configure installed plugins that require it ]]
require('Comment').setup()
require('fidget').setup({})
require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})
require('lualine').setup({
  options = {
    component_separators = '|',
    section_separators = '',
  }
})
require('mason').setup()
require('mason-lspconfig').setup()
require('nvim-autopairs').setup({})
require('unimpaired').setup({})
require('which-key').setup({})

-- [[ options ]]
vim.opt.clipboard = 'unnamedplus' -- clipboard behaves naturally
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- recommended menu completion values for nvim-cmp
vim.opt.expandtab = true -- insert spaces rather than tabs
vim.opt.guicursor = 'i-n-v-c-sm:block' -- use block cursor in all modes
vim.opt.hlsearch = false -- switch off permanent highlighting for search terms
vim.opt.ignorecase = true -- ignore case on search
vim.opt.number = true -- enable line numbers
vim.opt.mouse = 'a' -- enable mouse in all modes
vim.opt.relativenumber = true -- enable relative line numbers
vim.opt.smartcase = true -- ignore uppercase unless the search time has uppercase
vim.opt.shiftwidth = 4 -- default indent size
vim.opt.tabstop = 4 -- number of spaces displayed for a tab character
vim.opt.termguicolors = true -- use 24-bit colour in the terminal
vim.opt.wrap = false -- do not wrap text by default

-- [[ k and j behave naturally when line wrapping is on ]]
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ language-specific indent sizes  ]]
vim.cmd([[
  au FileType gitcommit set tw=100
  au FileType gitcommit setlocal spell spelllang=en_gb
  au FileType javascript setlocal shiftwidth=2 tabstop=2
  au FileType json setlocal shiftwidth=2 tabstop=2
  au FileType just setlocal shiftwidth=2 tabstop=2
  au FileType lua setlocal shiftwidth=2 tabstop=2
  au FileType markdown setlocal spell spelllang=en_gb
  au FileType markdown set wrap
  au FileType puppet setlocal shiftwidth=2 tabstop=2
  au FileType ruby setlocal shiftwidth=2 tabstop=2
  au FileType sh setlocal shiftwidth=2 tabstop=2
  au FileType typescript setlocal shiftwidth=2 tabstop=2
  au FileType yaml setlocal shiftwidth=2 tabstop=2
]])

-- [[ lsp configuration ]]
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- buffer local mappings
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "go to declaration" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.pyright.setup({})
require('rust-tools').setup({})

-- [[ autocompletion configuration ]]
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'buffer', keyword_length = 2 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete({}),
  })
})

-- [[ telescope configuration ]]
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', telescope.find_files, {})
vim.keymap.set('n', '<leader>gf', telescope.git_files, { desc = 'search git files' })
vim.keymap.set('n', '<leader>rg', telescope.live_grep, { desc = 'grep files' })
vim.keymap.set('n', '<leader>gc', telescope.git_commits, { desc = 'search git commits' })
vim.keymap.set('n', '<leader>em', telescope.diagnostics, { desc = 'error messages' })
vim.keymap.set('n', '<leader>m', telescope.marks, { desc = 'show marks' })
vim.keymap.set('n', '<leader>t', telescope.treesitter, { desc = 'treesitter browser' })
require('telescope').load_extension('fzf')

-- [[ treesitter configuration ]]
require('nvim-treesitter.configs').setup({
  ensure_install = {
    'bash',
    'json',
    'python',
    'rust',
    'terraform',
    'toml',
    'yaml'
  },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true }
})
