# https://github.com/polkit-org/polkit
{
  security.polkit = {
    enable = true;
  };
  environment.etc."polkit-1/rules.d/50-runners.rules".source = ./50-runners.rules;
}
