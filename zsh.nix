# This file should be imported by your main home-manager configuration.
{ pkgs, lib, ... }:

{
  # 1. Enable and configure the Zsh shell
  programs.zsh = {
    enable = true;
    # To make Zsh your default shell after applying this configuration,
    # you may need to run the following command in your terminal:
    # chsh -s $(which zsh)

    # 2. Configure the Oh My Zsh framework
    oh-my-zsh = {
      enable = true;
      # Set your desired theme, matching your .zshrc
      theme = "alanpeabody";
      # List of built-in plugins to use from the standard Oh My Zsh distribution.
      # The 'git' plugin is included here as you had it.
      plugins = [ "git" ];
    };

    # 3. Set variables for Oh My Zsh
    # This is the correct place for variables that must be defined
    # before Oh My Zsh and its plugins are loaded. This directly
    # corresponds to the settings at the top of your .zshrc.
    initContent = lib.mkOrder 550 ''
      # Enable command correction
      ENABLE_CORRECTION="true"

      # Disable the "untracked files" message in the git prompt
      DISABLE_UNTRACKED_FILES_DIRTY="true"
    '';

    # 4. Add custom/external plugins
    # This is the modern, declarative way to add plugins that are not
    # included with Oh My Zsh by default.
    plugins = [
      {
        # The name here corresponds to the plugin's directory name.
        name = "zsh-navigation-tools";
        src = pkgs.fetchFromGitHub {
          owner = "psprint";
          repo = "zsh-navigation-tools";
          # It is best practice to pin to a specific version tag or commit hash.
          rev = "v2.2.7";
          # The SHA256 hash ensures the integrity and reproducibility of the build.
          # If you change the 'rev' above, you must update this hash.
          sha256 = "SF+8UX+pnrd/1nThPD/IYjTRbIAIe2o7Mmjlq1JYkzA=";
        };
      }
    ];

    # 5. You can still define shell aliases here
    shellAliases = {
      ll = "ls -lF";
      la = "ls -laF";
      homesw = "home-manager switch --flake .#mwoodson";
      # Add any other aliases you use
    };
  };
}

