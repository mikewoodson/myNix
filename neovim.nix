# ~/.config/nix-config/config/nvim.nix
{ pkgs, ... }:

{
  # nvim Configuration using NixVim
  programs.nixvim = {
    enable = true;
    defaultEditor = true; # Sets `nvim` as the default `vi` and `editor`
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Some basic editor options
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 3;
      tabstop = 3;
      expandtab = true;
    };

    # Set the leader key
    globals.mapleader = "\\";

    # Add plugins
    plugins = {
      # LSP and completion
      lsp = {
        enable = true;
        servers = {
          # Add language servers you need here
          # Example: nixd for Nix language support
          nixd.enable = true;
        };
      };
      cmp = {
        enable = true;
        settings = {
           mapping = {
              "<Tab>" = "cmp.mapping.select_next_item()";
              "<S-Tab>" = "cmp.mapping.select_prev_item()";

              "<CR>" = "cmp.mapping.confirm({ select = true })";

              "<C-n>" = "cmp.mapping.scroll_docs(4)";
              "<C-p>" = "cmp.mapping.scroll_docs(-4)";
           };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
          ];
        };
      };

      treesitter = {
        enable = true;
        settings = {
           ensure_installed = [ "lua" "nix" ];
        };
      };

      # Fuzzy finding with Telescope
      telescope = {
        enable = true;
        settings.defaults = {
          mappings = {
            i = {
               "<CR>" = "select_tab";
            };
          };
        };
      };

      web-devicons.enable= true;

    };
    colorschemes.gruvbox.enable = true;

    extraConfigLua = ''
      vim.keymap.set('i', 'jj', '<Esc>')
    '';
    # Add extra keybindings
    keymaps = [
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find Files";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live Grep";
      }
    ];
  };
}
