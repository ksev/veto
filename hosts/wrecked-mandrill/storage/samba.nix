{config, ...}: {
  users.users.samba = {
    isSystemUser = true;
    group = "storage";
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "bind interfaces only" = "yes";
        "hosts allow" = "ALL";
        "interfaces" = "lo 10.123.0.5 2001:9b1:4fe:4402:9837:2dff:fe73:95ef";
        "server string" = config.networking.hostName;
        "netbios name" = config.networking.hostName;
        "security" = "user";
        "use sendfile" = "yes";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "Media" = {
        "path" = "/storage/Media";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "create mask" = "0654";
        "directory mask" = "0765";
        "force user" = "samba";
        "force group" = "storage";
      };
      "Vault" = {
        "path" = "/storage/Vault";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0654";
        "directory mask" = "0765";
        "force user" = "samba";
        "force group" = "storage";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
