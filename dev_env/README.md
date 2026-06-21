# Unified Developer Command CLI (`dev_env.ps1`)

A custom PowerShell script designed to streamline local development workflows. This script acts as a unified CLI wrapper (`dev`) for managing Python virtual environments, launching VS Code, executing Git commits, and safely tearing down the workspace.

## Features
- **Zero-Friction Git Flow:** Stage, commit, and push to `origin main` in a single command.
- **Smart Environment Bootstrapping:** Automatically detects if a Python virtual environment exists. If not, it creates it before activating.
- **Seamless IDE Integration:** Activates the local environment and opens Visual Studio Code in the current directory.
- **Clean Teardown:** Safely targets and closes the VS Code instance associated with the active project, deactivates the virtual environment, and exits the terminal session.

## Installation

To use this globally across your system, append the contents of `dev_env.ps1` to your PowerShell Profile.

1. Open a modern PowerShell terminal (`pwsh`).
2. Open your profile in Notepad:
   ```powershell
   notepad $PROFILE
   ```
   (If the file does not exist, run `New-Item -Path $PROFILE -Type File -Force` first).
3. Copy the contents of `dev_env.ps1` into your profile and save.
4. Reload the profile to apply changes:
   ```ps
   . $PROFILE
   ```

## Usage
Use the `dev` command followed by the desired action from the root of your project directory.
| Command | Action |
| `dev <venv_name>` | Creates (if missing) and activates the virtual environment, then launches VS Code. |
| `dev local <venv_name>` | Creates (if missing) and activates the virtual environment natively in the current terminal. |
| `dev commit "your message"` | Stages all tracked/untracked changes, commits with the provided message, and pushes to `origin main`. | 
| `dev down` (or `deactivate`) | Identifies the active project's VS Code window and safely closes it, deactivates the virtual environment, and terminates the PowerShell session. |

## Requirements
- **PowerShell:** Version 5.1 or newer (PowerShell 7 / `pwsh` recommended).
- **Python:** Must be installed and added to your system `PATH`.
- **Git:** Must be installed and configured.
- **VS Code:** Must be installed with the `code` command added to your `PATH`.