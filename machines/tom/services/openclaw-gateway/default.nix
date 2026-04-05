# https://github.com/openclaw/openclaw
{ config, pkgs, ... }:
{
  services.openclaw-gateway = {
    enable = true;
    config = {
      agents = {
        defaults = {
          maxConcurrent = 4;
          model = {
            primary = "openai/gpt-5.4";
          };
          subagents = {
            maxConcurrent = 8;
          };
          workspace = "/var/lib/openclaw/workspace";
        };
      };
      auth = {
        profiles = {
          "anthropic:default" = {
            provider = "anthropic";
            mode = "api_key";
          };
          "openai:default" = {
            provider = "openai";
            mode = "api_key";
          };
        };
      };
      browser = {
        enabled = false;
      };
      channels = {
        slack = {
          enabled = true;
          channels = {
            "C03VCFT5GTX" = {
              enabled = true;
            };
            "C040KHFGMPY" = {
              enabled = true;
            };
            "C041V3KQW81" = {
              enabled = true;
            };
            "C043U188EDS" = {
              enabled = true;
            };
            "C04CRUE6MU3" = {
              enabled = true;
            };
            "C05GLQ05L2W" = {
              enabled = true;
            };
            "C05RQ2FKE2Y" = {
              enabled = true;
            };
            "C064YRT8WDR" = {
              enabled = true;
            };
            "C06HQ3CC6SD" = {
              enabled = true;
            };
            "C073324A4QJ" = {
              enabled = true;
            };
            "C073329N8FL" = {
              enabled = true;
            };
            "C07331ZRZMG" = {
              enabled = true;
            };
            "C0732UG1F6F" = {
              enabled = true;
            };
            "C0744SEE1J8" = {
              enabled = true;
            };
            "C07EBSSKBPH" = {
              enabled = true;
            };
            "C07H53TDER4" = {
              enabled = true;
            };
            "C07JEU0KE0K" = {
              enabled = true;
            };
            "C07MQSN1LHE" = {
              enabled = true;
            };
            "C079K702X3R" = {
              enabled = true;
            };
            "C08M8DH4MDF" = {
              enabled = true;
            };
            "C0942M6KZGF" = {
              enabled = true;
            };
            "C0AFXED2MJB" = {
              enabled = true;
            };
            "C0AGMPZK4RJ" = {
              enabled = true;
            };
            "C0AQ0JM6B7E" = {
              enabled = true;
            };
            "C0AQVMBBVFF" = {
              enabled = true;
            };
          };
          allowFrom = [
            "U02APLEMRPS"
            "U04051AF9NJ"
          ];
          dmPolicy = "allowlist";
          groupPolicy = "allowlist";
          mode = "http";
          nativeStreaming = true;
          replyToMode = "all";
          signingSecret = {
            source = "env";
            provider = "default";
            id = "SLACK_SIGNING_SECRET";
          };
          slashCommand = {
            enabled = true;
            name = "TOM";
          };
          streaming = "partial";
          userTokenReadOnly = true;
          webhookPath = "/slack/events";
        };
      };
      commands = {
        allowFrom = {
          slack = [
            "U02APLEMRPS"
            "U04051AF9NJ"
          ];
        };
        bash = false;
        config = false;
        native = "auto";
        text = true;
        useAccessGroups = true;
      };
      gateway = {
        auth = {
          mode = "trusted-proxy";
          trustedProxy = {
            allowUsers = [ "slack" ];
            requiredHeaders = [ "x-slack-signature" ];
            userHeader = "x-forwarded-user";
          };
        };
        bind = "lan";
        controlUi = {
          enabled = false;
        };
        mode = "local";
        trustedProxies = [ "10.100.0.1" ];
      };
      tools = {
        profile = "coding";
        web = {
          search = {
            enabled = true;
            apiKey = {
              source = "env";
              provider = "default";
              id = "BRAVE_API_KEY";
            };
            cacheTtlMinutes = 15;
            maxResults = 5;
            provider = "brave";
            timeoutSeconds = 30;
          };
        };
      };
    };
    environment = {
      NODE_ENV = "production";
      OPENCLAW_CONFIG_PATH = "/var/lib/openclaw/openclaw.json";
    };
    environmentFiles = [ config.sops.secrets."openclaw".path ];
    execStartPre = [
      "${pkgs.coreutils}/bin/cp /etc/openclaw/openclaw.json /var/lib/openclaw/openclaw.json"
    ];
    group = "openclaw";
    logPath = "/var/lib/openclaw/gateway.log";
    port = 18789;
    stateDir = "/var/lib/openclaw";
    user = "openclaw";
  };
}
