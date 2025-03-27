{
  imports = [
    ./fs.nix
    ./samba.nix
  ];

  users.groups.storage = {
    # Add our default users
    members = ["root" "kim"];
  };
}
