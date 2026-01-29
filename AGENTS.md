# Agentic Development Guidelines for NixOS Dotfiles

This document serves as the primary reference for AI agents and developers working on this NixOS configuration repository. It defines the project structure, build workflows, and strict coding standards required to maintain a clean, reproducible, and robust system configuration.

## 1. Project Overview & Architecture

This repository manages NixOS system configurations and Home Manager user environments using **Nix Flakes**.

### Recommended Directory Structure
Agents should adhere to the following structure when adding new configurations:

```
.
├── flake.nix             # Development environment for working on the project (inputs, outputs, colmena/deploy-rs, checks)
├── flake.lock            # Pinned dependencies
├── hosts/                # Per-host configurations (nixosConfigurations)
│   ├── flake.nix         # Entrypoint for nixos systems (inputs, outputs, colmena/deploy-rs, checks)
│   ├── desktop/          # Host-specific directory
│   │   ├── default.nix   # Host entry point
│   │   └── hardware.nix  # Hardware scan
│   └── laptop/
├── modules/              # Reusable modules
│   ├── nixos/            # System-level modules (services, hardware)
│   └── home/             # Home Manager modules (programs, dotfiles)
├── dotfiles/             # Raw configuration files (zsh, ssh, config/...)
├── pkgs/                 # Custom packages (overlay)
└── lib/                  # Custom library functions
```

## 2. Build, Test, and Lint Commands

Agents must verify changes before confirming completion.

### System Management
*   **Apply NixOS System Config**:
    ```bash
    # Apply configuration for the current host (requires hostname to match flake output)
    sudo nixos-rebuild switch --flake .#<hostname>
    
    # Build without switching (safer for testing syntax/build failures)
    nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel
    ```

*   **Apply Home Manager Config** (Standalone):
    ```bash
    home-manager switch --flake .#<user>@<host>
    ```

### Validation & Linting
Since this is a configuration repo, "tests" are primarily build checks and linting.

*   **Check Flake Validity**:
    ```bash
    nix flake check
    ```

*   **Format Code** (Strict Requirement):
    All Nix files must be formatted using `nixfmt` (RFC 166 standard).
    ```bash
    nixfmt .
    ```

*   **Linting**:
    Use `statix` to check for anti-patterns and `deadnix` for unused code.
    ```bash
    statix check .
    deadnix .
    ```

*   **Run a Single "Test"** (Build a specific package/shell):
    If testing a custom package defined in `pkgs/`:
    ```bash
    nix build .#<package-name>
    ```

## 3. Code Style & Conventions

### General Principles
1.  **Flakes Everything**: Do not use legacy channels. All inputs must be defined in `flake.nix`.
2.  **Modularity**: Avoid monolithic `configuration.nix` files. Break configurations into logical modules (e.g., `modules/nixos/gaming.nix`, `modules/home/zsh.nix`).
3.  **Idempotency**: Ensure configurations are reproducible. Avoid manual state changes outside of Nix.

### Nix Language Guidelines

*   **Formatting**:
    *   Indent with 2 spaces.
    *   Align `=` in let-blocks if it improves readability, but prefer standard formatter output.
    *   Use multi-line strings (`'' ... ''`) for shell scripts or configuration files embedded in Nix.

*   **Imports**:
    *   Use relative paths: `imports = [ ./hardware.nix ../../modules/common.nix ];`.
    *   Keep imports at the top of the file.

*   **Naming Conventions**:
    *   **Files**: kebab-case (e.g., `nvidia-drivers.nix`).
    *   **Variables**: camelCase (e.g., `extraPackages`).
    *   **Option Definitions**: Use fully qualified paths (e.g., `services.openssh.enable`).

*   **Syntax Preferences**:
    *   **Inherit**: extensively use `inherit` to reduce repetition.
        ```nix
        # Good
        inherit (pkgs) git vim;
        
        # Bad
        git = pkgs.git;
        vim = pkgs.vim;
        ```
    *   **Argument Destructuring**: Destructure arguments in the function header.
        ```nix
        # Good
        { config, pkgs, lib, ... }:
        
        # Bad
        args: let pkgs = args.pkgs; in ...
        ```
    *   **Library Usage**: Use `lib` functions over raw builtins where possible (e.g., `lib.strings.concatStringsSep` vs `builtins.concatStringsSep`).

*   **Comments**:
    *   Comment complex logic or "magic" hacks required for hardware quirks.
    *   Do not leave commented-out code blocks; delete them.

### Error Handling & Debugging
*   Use `lib.warn` or `lib.assert` to enforce valid configuration states in custom modules.
    ```nix
    config = lib.mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.user != "";
          message = "User must be specified for this service.";
        }
      ];
    };
    ```
*   To debug variables during evaluation (use sparingly):
    ```nix
    builtins.trace "Value is: ${toString val}" val
    ```

## 4. Configuration Management (Dotfiles)

When adding configuration for external programs (e.g., Neovim, Hyprland, Git):

1.  **Prefer Home Manager**: Use Home Manager options (e.g., `programs.git.enable = true;`) whenever possible.
2.  **Config Files**: If a program lacks native Home Manager options, use `xdg.configFile` or `home.file`.
    ```nix
    xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
    ```
3.  **Secrets**: **NEVER** commit secrets (API keys, passwords, private keys) to git.
    *   Use `sops-nix` or `agenix` for secret management.
    *   Reference secrets via paths (e.g., `/run/secrets/my-secret`).

## 5. Agent Operational Protocol

*   **Analysis First**: Before editing, run `ls -R` or `nix flake show` to understand the current structure.
*   **Incremental Changes**: When adding a new host or large module, implement the skeleton first, then fill in details.
*   **Safety**: Always verify `flake.lock` updates are intentional. Do not arbitrarily update the lockfile unless requested (e.g., "update system").
*   **Commit Messages**: Follow Conventional Commits (e.g., `feat(nixos): add steam module`, `fix(home): correct zsh aliases`).

---
*Generated for opencode agents.*
