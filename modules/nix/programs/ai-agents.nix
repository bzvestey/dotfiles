{ pkgs, ... }:

{
  environment.variables.MATRIX_DM_AUTO_THREAD = "true";

  systemd.user.units."hermes-gateway.service" = {
    overrideStrategy = "asDropin";
    text = ''
      [Service]
      Environment=MATRIX_DM_AUTO_THREAD=true
    '';
  };

  environment.systemPackages = with pkgs.llm-agents; [
    hermes-agent
    hermes-desktop
    hermes-hud

    zeroclaw
  ];
}
