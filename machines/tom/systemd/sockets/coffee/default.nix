{ ... }:
{
  systemd = {
    tmpfiles = {
      rules = [ "d /run/receipts 0750 root hermes -" ];
    };
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
      receipts-history = {
        description = "Coffee history log reader";
        wantedBy = [ "sockets.target" ];
        listenStreams = [ "/run/receipts/history" ];
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
