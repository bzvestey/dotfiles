{
  ...
}:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        addKeysToAgent = "yes";
      };
      "knot.minastas.xyz" = {
        "HostName" = "knot-ssh.tailbc181.ts.net";
        "User" = "git";
      };
    };
  };
}
