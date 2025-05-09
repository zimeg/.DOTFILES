# https://github.com/openssh/openssh-portable
{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "ez" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
