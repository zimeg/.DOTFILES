# https://github.com/openssh/openssh-portable
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # https://github.com/zimeg/.DOTFILES/issues/56
    settings = {
      "*" = {
        AddKeysToAgent = "no";
        Compression = false;
        ControlMaster = "no";
        ControlPath = "~/.ssh/control-%r@%n:%p";
        ControlPersist = "no";
        ForwardAgent = false;
        HashKnownHosts = false;
        ServerAliveCountMax = 2;
        ServerAliveInterval = 0;
        UserKnownHostsFile = "~/.ssh/known_hosts";
      };
      "git.o526.net" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };
      tim = {
        HostName = "eztim25";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
        RemoteCommand = "tmux attach";
        RequestTTY = true;
      };
      tom = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
        RemoteCommand = "tmux attach";
        RequestTTY = true;
      };
    };
  };
}
