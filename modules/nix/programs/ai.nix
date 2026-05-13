{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.llm-agents; [
    # Coding tools
    claude-code
    gemini-cli
    opencode

    # Agents
    (zeroclaw.overrideAttrs (old: {
      cargoBuildFeatures = (old.cargoBuildFeatures or []) ++ [ "channel-matrix" ];
      postPatch = (old.postPatch or "") + ''
        sed -i '1s/^/#![recursion_limit = "512"]\n/' \
          "$cargoDepsCopy/source-registry-0/matrix-sdk-0.16.0/src/lib.rs"
        sed -i '1s/^/#![recursion_limit = "512"]\n/' \
          crates/zeroclaw-channels/src/lib.rs
      '';
    }))
  ];
}
