{
  pkgs,
  ...
}:

{
  # Setup VSCode
  programs.vscode = {
    enable = true;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers
      rust-lang.rust-analyzer
      nefrob.vscode-just-syntax
      redhat.ansible
      redhat.vscode-yaml
      antyos.openscad
    ];
  };
}
