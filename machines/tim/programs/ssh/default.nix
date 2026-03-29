# https://github.com/openssh/openssh-portable
{
  programs.ssh.matchBlocks = {
    theorderingmachine = {
      hostname = "github.com";
      identitiesOnly = true;
      identityFile = "~/.ssh/accounts/theorderingmachine";
    };
    zimeg = {
      hostname = "github.com";
      identitiesOnly = true;
      identityFile = "~/.ssh/accounts/zimeg";
    };
  };
}
