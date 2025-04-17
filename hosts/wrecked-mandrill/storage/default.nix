{
  imports = [
    ./fs.nix
    ./samba.nix
  ];

  users.groups.storage = {
    gid = 993;
    # Add our default users
    members = ["root" "kim"];
  };
}
