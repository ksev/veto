{
  imports = [
    ./dns.nix
    ./arr.nix
    ./redlib.nix
  ];

  users.users.microvm.extraGroups = ["storage"];
}
