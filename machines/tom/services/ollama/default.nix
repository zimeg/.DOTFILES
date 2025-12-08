# https://github.com/ollama/ollama
{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    models = "/etc/ollama/models";
    user = "ollama";
  };
}
