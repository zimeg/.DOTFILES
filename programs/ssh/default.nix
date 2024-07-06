# https://github.com/openssh/openssh-portable
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = "${builtins.getEnv "HOME"}/.ssh/id_ed25519";
      };
      tom = {
        hostname = "192.168.86.37";
        identitiesOnly = true;
        identityFile = "${builtins.getEnv "HOME"}/.ssh/id_ed25519";
      };
    };
  };
}
