# https://github.com/git/git
{ pkgs, inputs, ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      last = "log -1 HEAD";
      list = "log --graph --pretty=format:'%C(yellow)%h%C(reset) %C(dim white)-%C(reset) %s %C(dim white)(%cr)%C(reset) %C(cyan)<%aN>%C(reset)%C(bold)%d%C(reset)' --abbrev-commit --date=relative";
      staged = "diff --staged";
      unstage = "restore --staged";
      update = "!git checkout main && git pull && git checkout - && git merge main --message 'chore: merge w main'";
      whatsnew = "diff HEAD@{1} HEAD";
      whereami = "!pwd && git branch --show-current";
      whoami = "!git config user.name && git config user.email";
    };
    extraConfig = {
      advice = {
        addEmptyPathspec = false;
      };
      color = {
        ui = "auto";
      };
      core = {
        editor = "nvim";
        ignorecase = true;
      };
      diff = {
        tool = "nvimdiff";
      };
      difftool = {
        nvimdiff = {
          cmd = "nvim -d $LOCAL $REMOTE";
        };
        prompt = false;
      };
      fetch = {
        prune = true;
      };
      filter = {
        lfs = {
          required = true;
          clean = "git-lfs clean -- %f";
          process = "git-lfs filter-process";
          smudge = "git-lfs smudge -- %f";
        };
      };
      init = {
        defaultBranch = "main";
      };
      mailmap = {
        file = "~/.config/git/mailmap";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "simple";
      };
    };
    delta = {
      enable = true;
      options = {
        syntax-theme = "ansi";
      };
    };
    ignores = [
      ".DS_Store"
    ];
    lfs = {
      enable = true;
    };
  };
  home.file.".config/git/mailmap" = {
    source = ./.mailmap;
  };
  home.packages = [
    inputs.git-coverage.packages.${pkgs.system}.default # https://github.com/zimeg/git-coverage
    pkgs.git-open # https://github.com/paulirish/git-open
    pkgs.git-who # https://github.com/sinclairtarget/git-who
  ];
}
