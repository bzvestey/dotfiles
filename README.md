# NixOS Configurations

This repository contains the NixOS system configurations and Home Manager user environments for my personal machines. It uses **Nix Flakes** for reproducible builds and efficient dependency management.

## 🚀 Getting Started

### Bootstrap a New Machine
To quickly set up a new machine (or an existing one not yet tracking this repo), run the bootstrap script. This will clone the repository, generate hardware configurations, and help apply the system state.

```bash
curl -L https://raw.githubusercontent.com/bzvestey/dotfiles/main/bootstrap.sh | bash
```

The script will prompt you to:
1.  **Apply an Existing Host**: If the machine matches a hostname in `hosts/`.
2.  **Create a New Host**: Generates a new host directory with a standard `default.nix` and `hardware.nix` derived from the current system.

### Manual Installation
If you prefer to set up manually:
1.  Clone the repo: `git clone https://github.com/bzvestey/dotfiles ~/dev/dotfiles`
2.  Generate hardware config: `nixos-generate-config --show-hardware-config > hosts/<new-host>/hardware.nix`
3.  Add the host to `flake.nix`.
4.  Build: `sudo nixos-rebuild switch --flake .#<host>`

## 🛠 Maintenance (Justfile)

This repository includes a `justfile` to simplify common maintenance tasks. Ensure [just](https://github.com/casey/just) is installed (it's included in the devShell).

| Command | Description |
| :--- | :--- |
| `just update` | Updates flake inputs (lockfile) to the latest versions. |
| `just switch` | Rebuilds and switches to the configuration matching the current hostname. |
| `just firmware` | Checks for and installs system firmware updates via `fwupdmgr`. |
| `just clean` | Garbage collects old generations and optimizes the Nix store. |

**Example:**
```bash
# Update everything and switch
just update && just switch
```

## 📂 Repository Structure

*   **`hosts/`**: Per-machine configurations (entry points).
*   **`modules/`**: Reusable NixOS and Home Manager modules.
    *   `nixos/`: System-level configs (hardware, services).
    *   `home/`: User-level configs (programs, dotfiles).
*   **`dotfiles/`**: Raw configuration files managed via Home Manager (e.g., zsh, ssh).
*   **`pkgs/`**: Custom packages not found in nixpkgs.
*   **`flake.nix`**: The project root, defining inputs and system outputs.

## 🤖 For AI Agents
See [AGENTS.md](./AGENTS.md) for strict guidelines on modifying this repository.
