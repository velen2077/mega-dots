{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}:
with lib; let
  cfg = config.cli.zsh;
in {
  options.cli.zsh = {
    enable = mkEnableOption "zsh config";
  };

  config = mkIf cfg.enable {
    programs.zsh = let
      myAliases = {
        # ls = "ls -hN --color=auto --group-directories-first";
        ls = "eza --icons=always --color-scale=all --color=always --group-directories-first --color-scale-mode=gradient";
        rf = "rm -rf";
        # cat = "bat";

        df = "cd ~/.dotfiles";
        dw = "cd ~/Downloads";
        dc = "cd ~/Documents";
        oo = "cd $NOTES_DIR";

        nv = "nvim";
        nnv = "~/.config/nvim/result/bin/nvim";
        z = "zellij";
        lg = "lazygit";

        gst = "git status";
        gadd = "git add .";
        gcm = "git commit -m ";
        glog = "git log --oneline --graph --decorate";
        gps = "git push";
        gpl = "git pull";
        gplr = "git pull --rebase";
      };
    in {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      historySubstringSearch.enable = true;
      defaultKeymap = "emacs";
      initExtra = ''
        bindkey '^n' history-search-forward
        bindkey '^p' history-search-backward
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        eval "$(fzf --zsh)"
        eval "$(direnv hook zsh)"
        if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        fi
      '';

      history = {
        size = 100000;
        path = "${config.xdg.dataHome}/zsh/history";
        extended = true;
        ignoreAllDups = true;
        share = true;
        ignoreSpace = true; # don't save in hist if cmd starts with space
      };
      plugins = [
        {
          # will source zsh-autosuggestions.plugin.zsh
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.4.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
        }
      ];
    };
    home.packages = with pkgs; [fzf];
  };
}
