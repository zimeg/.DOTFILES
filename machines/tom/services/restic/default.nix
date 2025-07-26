# https://github.com/restic/restic
{
  services.restic.backups = {
    minecraft = {
      initialize = true;
      environmentFile = "/run/secrets/aws/iam/minecraft";
      passwordFile = "/run/secrets/restic/minecraft";
      repository = "s3:s3.us-east-1.amazonaws.com/tom.25565";
      paths = [
        "/srv/minecraft/world"
      ];
      pruneOpts = [
        "--keep-daily 5"
        "--keep-weekly 6"
        "--keep-monthly 12"
        "--keep-yearly 60"
      ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
