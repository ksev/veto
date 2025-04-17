{
  servicevm.redlib = {
    ip = "10.123.0.15";
    mac = "12:44:37:ea:c6:1f";

    config = {
      services.redlib = {
        enable = true;
        address = "127.0.0.1";
      };

      networking.firewall = {
        allowedTCPPorts = [80 443];
        allowedUDPPorts = [80 443];
      };

      services.caddy = {
        enable = true;
        virtualHosts."rlib.kotee.co".extraConfig = ''
          reverse_proxy http://127.0.0.1:8080
        '';
      };
    };
  };
}
