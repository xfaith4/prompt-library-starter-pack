# Roadmap — Prompt Library Starter Pack

## Product Intent

**Prompt Library Starter Pack** is a Git-versioned collection of reusable `.prompt.md` files for directing AI coding agents (GitHub Copilot Chat and Claude Code). It serves developers who want consistent, repeatable instructions for approvals, reviews, hardening passes, roadmap discipline, writing, and session continuity — without typing them from scratch each time.

**Problem it solves:** ad-hoc prompting produces inconsistent agent behaviour and makes it hard to share or evolve a team's prompting practice. This library gives those prompts a canonical home, a documented format, and install tooling to push them into both chat surfaces with one script.

**Who it serves:** individual developers and small teams using VS Code with GitHub Copilot Chat and/or Claude Code who want structured, version-controlled prompts.

---

## Release 0.1 — Foundation

**Goal:** establish a working prompt library with install tooling, governance, and all core prompt categories shipped and documented.

### Checklist

- [x] Define `.prompt.md` file format (YAML frontmatter + body)
- [x] Create `00-governance/` — naming conventions and library standards prompts
- [x] Create `01-coding/` — approval and execution prompts
- [x] Create `02-review/` — review, hardening, and acceptance prompts
- [x] Create `03-planning/` — roadmap, sequencing, and documentation prompts
- [x] Create `04-writing/` — rewrite and communication prompts
- [x] Create `05-session/` — session continuity and wrap-up prompts
- [x] Create `99-archive/` — retired material excluded from installs by default
- [x] Implement `tools/Install-VSCode-Prompts.ps1` with `-WhatIf`, `-PruneStale`, `-Channel`
- [x] Implement `tools/Install-ClaudeCode-Prompts.ps1` with `-WhatIf`, `-PruneStale`
- [x] Implement `tools/Uninstall-VSCode-Prompts.ps1` and `Uninstall-ClaudeCode-Prompts.ps1`
- [x] Add VS Code tasks for install, sync, and uninstall
- [x] Write README with folder layout, install instructions, and everyday workflow

### Acceptance criteria

- All prompt categories listed above have at least one `.prompt.md` file that installs without error.
- Install scripts complete without error on Windows with PowerShell 7+.
- `-WhatIf` mode produces output but makes no file system changes.
- `-PruneStale` removes installed files whose source was renamed or archived.
- README describes the format, folder layout, all four install/sync commands, and the everyday workflow.

### Out of scope

- Cross-platform (Linux/macOS) shell install scripts.
- Automated test harness for the install scripts.
- A web UI or hosted prompt catalogue.

---

## Release 0.2 — Cross-platform and Quality

**Goal:** extend install tooling to Linux and macOS, add a lightweight validation script to catch malformed prompt files before install, and improve the governance prompts based on real-world use.

### Checklist

- [ ] Add `tools/Install-VSCode-Prompts.sh` and `tools/Install-ClaudeCode-Prompts.sh` for Linux/macOS
- [ ] Add `tools/Uninstall-VSCode-Prompts.sh` and `tools/Uninstall-ClaudeCode-Prompts.sh`
- [ ] Add `tools/Validate-Prompts.ps1` (and `.sh`) that checks each `.prompt.md` has valid YAML frontmatter and a non-empty `description` field
- [ ] Document shell scripts in README alongside the PowerShell equivalents
- [ ] Review and refine governance prompts based on real-world feedback
- [ ] Add a `CONTRIBUTING.md` with the prompt authoring checklist

### Acceptance criteria

- Shell install scripts behave identically to their PowerShell counterparts on Ubuntu and macOS.
- `Validate-Prompts` exits non-zero and prints a diagnostic when a prompt file is missing its `description` or has malformed YAML.
- All existing PowerShell script tests (if added) continue to pass.
- README and CONTRIBUTING.md are consistent with each other.

### Out of scope

- Automatic prompt quality scoring or AI-assisted prompt linting.
- Hosting prompts in a package registry.
- Syncing prompts to chat surfaces other than VS Code Copilot Chat and Claude Code.
