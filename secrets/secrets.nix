let
  bzvestey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMpx0yPdFPKUFBLn6OKJJAyqnlvoLmll4m97l/YMLu8 bryan@vestey.dev";
  framework16nix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKXbDDCw9gnBDAUvycllClmWEPzcRiuFoUawShA0wONh root@framework16nix";
  framework13nix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFfD4k6zC806/krEddvflrbDRCeP32SpJhB4oABb2RLH root@framework13nix";
  systems = [
    bzvestey
    framework16nix
    framework13nix
  ];
in
{
  "smb-credentials.age".publicKeys = systems;
  # syncthing-id.age.publicKeys = [ bzvestey ]
}
