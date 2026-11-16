# https://github.com/maintainersdotcoffee/shop
{ ... }:
{
  systemd = {
    sockets = {
      receipts-follow = {
        description = "streaming Maintainers Coffee logs";
        wantedBy = [ "sockets.target" ];
        listenStreams = [ "/run/receipts/follow" ];
        socketConfig = {
          Accept = true;
          MaxConnections = 4;
          RemoveOnStop = true;
          SocketGroup = "hermes";
          SocketMode = "0660";
          SocketUser = "root";
        };
      };
      receipts-output = {
        description = "outputted Maintainers Coffee logs";
        wantedBy = [ "sockets.target" ];
        listenStreams = [ "/run/receipts/output" ];
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
