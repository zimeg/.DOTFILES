# https://github.com/aws/aws-cli/tree/v2
{ pkgs, ... }:
{
  programs.awscli = {
    enable = true;
    credentials = {
      "default" = {
        "credential_process" = "${pkgs.coreutils}/bin/cat /run/secrets/aws/credentials";
      };
    };
    settings = {
      "default" = {
        region = "us-east-1";
      };
    };
  };
}
