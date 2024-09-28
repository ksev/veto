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
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fit -i ${config.stylix.image}";
      Restart="on-failure";
    };
  };
}
