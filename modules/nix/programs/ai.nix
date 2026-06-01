{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.llm-agents; [
    # Coding tools
    claude-code
    antigravity-cli
    opencode

    # Agents
    zeroclaw
  ];

  nix.settings.extra-substituters = [ "https://cache.numtide.com" ];
  nix.settings.extra-trusted-public-keys = [
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
  ];
}
