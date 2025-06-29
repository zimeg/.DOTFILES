# https://github.com/ollama/ollama
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    models = "/etc/ollama/models";
    user = "ollama";
  };
}
