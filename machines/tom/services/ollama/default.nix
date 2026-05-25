# https://github.com/ollama/ollama
{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [ "gemma4:26b" ];
    package = pkgs.ollama-cuda;
    models = "/etc/ollama/models";
    user = "ollama";
  };
}
