# AGENTS.md

This file contains guidelines and instructions for agentic coding agents working in this repository.

## Project Overview
This repository contains configuration files for Neovim/Vim, organized modularly.

## Build, Lint, and Test Commands

### Build
The project must be built before changes take effect, as it involves generating symbolic links and replacing namespaces.

- **Build Project:** `./scripts/build-vimrc.sh`

### Test & Lint
This repository consists of configuration files and helper scripts. There are no automated unit or integration tests for the configuration code itself.
- **Verification:** Verification of changes should be done by opening Neovim (`nvim`) and running `:checkhealth` or verifying specific plugin functionality.
- **Linting:** There is no dedicated linting setup. Adhere strictly to the existing code style in `lua/modules/`.

## Code Style Guidelines

### Lua Configuration
- **Modularization:** New plugins or configurations must be created as new files in `lua/modules/`.
- **Namespacing:** Use `NAMESPACE` as a placeholder in new modules. The build script (`scripts/build-vimrc.sh`) will automatically replace `NAMESPACE` with the configured `LUANAMESPACE` (`als56gh`).
- **Dependencies:** New dependencies should be managed via `composer.json` or system packages, as outlined in the `README.md`.
- **Formatting:** Mimic the indentation and structure of existing files in `lua/modules/`.
- **Naming Conventions:**
  - Modules: Use descriptive, snake_case names (e.g., `indent-guides.lua`).
  - Variables/Functions: Follow Lua/Neovim idiomatic naming conventions.
- **Error Handling:** Neovim config should fail gracefully. Wrap risky plugin configuration in `pcall` where appropriate.

### Vimscript
- **Location:** Keep Vimscript in `vim-native/` or `init.vim`.
- **Avoidance:** Prefer Lua configuration over Vimscript whenever possible.

### General
- **Comments:** Add comments sparingly, focusing on the "why" for complex configuration choices.
- **Proactiveness:** If modifying `scripts/build-vimrc.sh`, ensure the build process remains idempotent and symbolic links are correctly managed.

## Repository Rules

### Cursor/Copilot Rules
- No specific `.cursorrules` or `.github/copilot-instructions.md` are defined in this repository.
- Agents must adhere to the conventions defined in this `AGENTS.md` and observe the structure of existing `lua/modules/` files.

## Development Workflow
1.  **Understand:** Analyze `init.vim` and the relevant module in `lua/modules/`.
2.  **Edit:** Apply changes to the appropriate file in `lua/modules/`.
3.  **Build:** Run `./scripts/build-vimrc.sh` to propagate changes.
4.  **Verify:** Open Neovim, check for errors, and verify functionality.

---
*Last updated: 2026-05-09*
