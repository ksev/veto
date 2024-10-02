{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.swaybg = {
    Unit = {
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.stylix.image}";
      Restart="on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
