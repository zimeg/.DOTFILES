# https://github.com/openssh/openssh-portable
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };
      tom = {
        hostname = "192.168.86.37";
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
