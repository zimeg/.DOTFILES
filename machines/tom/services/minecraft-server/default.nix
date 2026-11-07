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
      white-list = true;
    };
    whitelist = {
      Left4Bread = "2730409b-9ace-475f-946c-e129fe0f2454";
      zimeg = "761b179a-d303-408a-92ae-1078d90a05ac";
    };
  };
}
