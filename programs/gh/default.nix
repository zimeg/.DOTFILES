# https://github.com/cli/cli
{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-poi # https://github.com/seachicken/gh-poi
    ];
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    settings = {
      git_protocol = "ssh";
    };
  };
  # https://github.com/dlvhdr/gh-dash
  programs.gh-dash = {
    enable = true;
    settings = {
      defaults = {
        layout = {
          issues = {
            creator = {
              width = 18;
            };
          };
        };
        preview = {
          width = 80;
        };
        refetchIntervalMinutes = 10;
      };
      issuesSections = [
        {
          title = "Involved";
          filters = "is:open sort:updated-desc involves:@me";
        }
        {
          title = "Bugs";
          filters = "is:open sort:updated-desc label:bug";
        }
        {
          title = "Questions";
          filters = "is:open sort:updated-desc label:question";
        }
        {
          title = "Open";
          filters = "is:open sort:updated-desc";
        }
        {
          title = "Closed";
          filters = "is:closed sort:updated-desc";
        }
        {
          title = "Untriaged";
          filters = "is:open sort:updated-desc label:untriaged";
        }
      ];
      pager = {
        diff = "delta";
      };
      prSections = [
        {
          title = "My Pull Requests";
          filters = "is:open author:@me";
        }
        {
          title = "Needs My Review";
          filters = "is:open review-requested:@me";
        }
        {
          title = "Involved";
          filters = "is:open involves:@me";
        }
        {
          title = "Open Changes";
          filters = "is:open";
        }
        {
          title = "Merged Changes";
          filters = "-author:app/dependabot is:closed is:merged";
        }
        {
          title = "Closed Changes";
          filters = "-author:app/dependabot is:closed is:unmerged";
        }
        {
          title = "Dependabot";
          filters = "author:app/dependabot";
        }
      ];
      theme = {
        icons = {
          owner = "";
          member = "";
          collaborator = "";
          contributor = "";
          newcontributor = "";
          unknownrole = "";
        };
      };
    };
  };
}
