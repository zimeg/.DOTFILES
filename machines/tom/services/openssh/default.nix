# https://github.com/openssh/openssh-portable
{
  services.openssh = {
    enable = true;
    knownHosts = {
      "github.com" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
    };
    settings = {
      AllowUsers = [ "ez" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  users.users.default.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZQSWnGNtSoSAaK90h3FYsxTlevad8+BpTzR2DwiT1C"
  ];
}
