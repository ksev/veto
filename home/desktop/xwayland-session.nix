
{
  pkgs,
  ...
}: {
  programs.niri.settings.environment."DISPLAY" = ":0";

  systemd.user.services.xwayland-satellite = {
    Unit = {
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart="on-failure";
    };
  };
}
