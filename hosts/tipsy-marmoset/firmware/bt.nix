{pkgs, ...}: let
  lunarLakeBt =
    pkgs.stdenvNoCC.mkDerivation
    {
      name = "copyfirmware";
      src = ./.;
      phases = ["unpackPhase" "installPhase"];
      installPhase = ''
        mkdir -p $out/lib/firmware/intel
        cp $src/ibt-0190-0291-iml.sfi $out/lib/firmware/intel/
        cp $src/ibt-0190-0291.sfi $out/lib/firmware/intel/
        cp $src/ibt-0190-0291.ddc $out/lib/firmware/intel/
      '';
    };
in {
  hardware.firmware = [
    lunarLakeBt
  ];
}
