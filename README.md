# PowerShell Scripts & Automation Toolkit

A central repository for custom PowerShell tools, CLI wrappers, and automation scripts designed to eliminate friction in local development, environment scaffolding, and general system administration.

Each tool is contained within its own directory with dedicated documentation.

## Project Directory

| Tool / Project         | Description                                                                                                                       | Documentation                               |
| :--------------------- | :-------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------ |
| **`dev_env`**          | A unified CLI wrapper (`dev`) for bootstrapping Python virtual environments, managing IDE launches, and streamlining Git commits. | [Read the Docs](./dev_env/README.md)        |
| **`[Next_Tool_Name]`** | *[Brief 1-2 sentence description of what the script automates or solves.]*                                                        | *[Link to Folder](./folder_name/README.md)* |
| **`[Next_Tool_Name]`** | *[Brief 1-2 sentence description of what the script automates or solves.]*                                                        | *[Link to Folder](./folder_name/README.md)* |

---

## Global Prerequisites

To run custom PowerShell scripts on a new Windows machine, you may need to update your system's execution policy. If you encounter an `Access is denied` or `Execution Policy` error, run PowerShell as an Administrator and execute:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## How to Add a New Tool
To keep this repository organized as it grows:
- Create a new directory for your script (e.g., `db_backup`).
- Add your `.ps1` script and any helper files into that directory.
- Include a scoped `README.md` inside that directory detailing its specific installation and usage.
- Add a new row to the Project Directory table above.

## Why this structure works:
* **The Table Template:** It creates a perfect visual index. Anyone (or just future you) looking at the repo immediately sees a catalog of your tools and can click straight to the specific instructions.
* **The Emojis:** They break up the wall of text and make the documentation highly scannable. 
* **The Global Prerequisites:** Adding the `Set-ExecutionPolicy` fix at the root level saves you from having to rewrite that specific troubleshooting step in every single sub-folder's README.