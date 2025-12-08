# https://github.com/openssh/openssh-portable
{
  services.openssh = {
    enable = true;
  };
  users.users.ez.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZQSWnGNtSoSAaK90h3FYsxTlevad8+BpTzR2DwiT1C"
  ];
}
