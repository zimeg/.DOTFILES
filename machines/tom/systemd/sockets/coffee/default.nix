# https://github.com/maintainersdotcoffee/shop
{ ... }:
{
  systemd = {
    sockets = {
      receipts-follow = {
        description = "Coffee follow log reader";
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
        description = "Coffee output log reader";
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
