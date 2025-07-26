# https://minecraft.fandom.com/wiki/Server.properties
{
  services.minecraft-server = {
    enable = true;
    dataDir = "/srv/minecraft";
    declarative = true;
    eula = true;
    openFirewall = true;
    serverProperties = {
      difficulty = "hard";
      force-gamemode = true;
      gamemode = "survival";
      level-name = "world";
      max-players = 2;
      motd = "thoughts of minecraft";
    };
  };
}
