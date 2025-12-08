# https://github.com/openssh/openssh-portable
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # https://github.com/zimeg/.DOTFILES/issues/56
    matchBlocks = {
      "*" = {
        addKeysToAgent = "no";
        compression = false;
        controlMaster = "no";
        controlPath = "~/.ssh/control-%r@%n:%p";
        controlPersist = "no";
        forwardAgent = false;
        hashKnownHosts = false;
        serverAliveCountMax = 2;
        serverAliveInterval = 0;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
      "github.com" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };
      tim = {
        hostname = "eztim25";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
        extraOptions = {
          RemoteCommand = "tmux attach";
          RequestTTY = "true";
        };
      };
      tom = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
        extraOptions = {
          RemoteCommand = "tmux attach";
          RequestTTY = "true";
        };
      };
    };
  };
}
