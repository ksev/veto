{pkgs, ...}: {
  systemd.services.mount-storage = {
    description = "Mount BcacheFS storage array";

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      mkdir -p /storage
      if ! ${pkgs.util-linux}/bin/mountpoint -q /storage; then
        ${pkgs.bcachefs-tools}/bin/bcachefs mount UUID=f8b1c2a5-16bf-42e3-9521-66e403ca6374 /storage;
      fi
    '';

    wantedBy = ["multi-user.target"];
  };

  boot.supportedFilesystems = ["bcachefs"];
}
