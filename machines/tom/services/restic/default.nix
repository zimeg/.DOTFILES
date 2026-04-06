# https://github.com/restic/restic
{
  services.restic.backups = {
    git = {
      initialize = true;
      user = "git";
      environmentFile = "/run/secrets/aws/iam/git";
      passwordFile = "/run/secrets/restic/git";
      repository = "s3:s3.us-east-1.amazonaws.com/tom.git";
      paths = [
        "/var/lib/soft-serve"
      ];
      pruneOpts = [
        "--keep-hourly 24"
        "--keep-daily 5"
        "--keep-weekly 6"
        "--keep-monthly 12"
        "--keep-yearly 60"
      ];
      timerConfig = {
        OnCalendar = "hourly";
        Persistent = true;
      };
    };
    minecraft = {
      initialize = true;
      user = "minecraft";
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
    openclaw = {
      initialize = true;
      user = "openclaw";
      environmentFile = "/run/secrets/aws/iam/openclaw";
      passwordFile = "/run/secrets/restic/openclaw";
      repository = "s3:s3.us-east-1.amazonaws.com/tom.openclaw";
      paths = [
        "/var/lib/openclaw"
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
