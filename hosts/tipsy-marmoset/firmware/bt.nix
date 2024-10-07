{pkgs, ...}: {
  hardware.firmware = [
    pkgs.stdenv.mkDerivation
    {
      name = "copyfirmware";
      src = ./.;
      phases = ["unpackPhase" "installPhase"];
      installPhase = ''
        mkdir -p $out/lib/firmware/intel        
        cp $src/ibt-0190-0291-iml.sfi $out/lib/firmware/intel/
      '';
    }
  ];
}
