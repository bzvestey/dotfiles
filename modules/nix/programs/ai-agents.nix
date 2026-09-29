{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.llm-agents; [
    hermes-agent
    hermes-desktop
    hermes-hud

    zeroclaw
  ];
}
