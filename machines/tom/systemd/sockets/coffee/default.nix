# https://github.com/maintainersdotcoffee/shop
{ ... }:
{
  systemd = {
    sockets = {
      coffee-receipts-follow = {
        description = "streaming Maintainers Coffee logs";
        wantedBy = [ "sockets.target" ];
        listenStreams = [ "/run/coffee/receipts/follow" ];
        socketConfig = {
          Accept = true;
          MaxConnections = 4;
          RemoveOnStop = true;
          SocketGroup = "hermes";
          SocketMode = "0660";
          SocketUser = "root";
        };
      };
      coffee-receipts-output = {
        description = "outputted Maintainers Coffee logs";
        wantedBy = [ "sockets.target" ];
        listenStreams = [ "/run/coffee/receipts/output" ];
        socketConfig = {
          Accept = true;
          MaxConnections = 4;
          RemoveOnStop = true;
          SocketGroup = "hermes";
          SocketMode = "0660";
          SocketUser = "root";
        };
      };
    };
  };
}
