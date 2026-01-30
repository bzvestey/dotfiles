let
  bzvestey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMpx0yPdFPKUFBLn6OKJJAyqnlvoLmll4m97l/YMLu8 bryan@vestey.dev";
  # host = "ssh-ed25519 ..."; # Add host key here later
  systems = [ bzvestey ];
in
{
  # "secret1.age".publicKeys = systems;
  # syncthing-id.age.publicKeys = [ bzvestey ]
}
