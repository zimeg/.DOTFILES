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
        hostname = "100.76.34.103";
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
