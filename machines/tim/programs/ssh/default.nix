# https://github.com/openssh/openssh-portable
{
  programs.ssh.settings = {
    theorderingmachine = {
      HostName = "github.com";
      IdentitiesOnly = true;
      IdentityFile = "~/.ssh/accounts/theorderingmachine";
    };
    zimeg = {
      HostName = "github.com";
      IdentitiesOnly = true;
      IdentityFile = "~/.ssh/accounts/zimeg";
    };
  };
}
