# Prompt Library Starter Pack

A Git-versioned library of reusable prompts for directing coding agents: approvals, reviews, hardening passes, roadmap discipline, writing, and session continuity.

Each `.prompt.md` file is one prompt in a format that installs directly into **two chat surfaces**:

- **GitHub Copilot Chat** in VS Code, as user prompt files (type `/` in the chat input).
- **Claude Code**, as user-level slash commands (type `/` in the chat input).

This repo is the canonical source. Edit prompts here, then sync them out with the install scripts below.

## Prompt file format

Every active prompt file contains YAML frontmatter with a one-line `description`, followed by the prompt body — nothing else:

```markdown
---
description: Approve a reviewed direction and instruct the agent to implement immediately. Use when sequencing is already clear.
---

Approved. Your findings and recommended direction are valid.

Proceed with implementation now. ...
```

Both Copilot Chat and Claude Code read the `description` for their command pickers and inject the body as the prompt. Keep the description to one sentence of purpose plus one sentence of when to use it.

## Folder layout

- `00-governance/` — standards, naming, maintenance rules
- `01-coding/` — approval and execution prompts
- `02-review/` — review, hardening, and acceptance prompts
- `03-planning/` — roadmap, sequencing, and documentation prompts
- `04-writing/` — rewrite and communication prompts
- `05-session/` — session continuity and wrap-up prompts
- `99-archive/` — retired or superseded material (never installed by default)
- `tools/` — PowerShell install, sync, and uninstall scripts

## Install

All scripts support `-WhatIf` for a dry run. The easiest path in VS Code: **Terminal → Run Task → Prompt Library: Install All (VS Code + Claude Code)**.

### Into VS Code (Copilot Chat)

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-VSCode-Prompts.ps1            # Stable
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-VSCode-Prompts.ps1 -Channel Both
```

Prompt files are copied **flat** into `%APPDATA%\Code\User\prompts\` because VS Code prompt discovery does not scan subfolders ([microsoft/vscode#268780](https://github.com/microsoft/vscode/issues/268780)). A manifest file written alongside them tracks exactly which files this library installed, so sync and uninstall never touch prompts you created yourself.

### Into Claude Code

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-ClaudeCode-Prompts.ps1
```

Each file is installed into `~\.claude\commands\prompt-library\` as a lowercased slash command, e.g. `Coding-Implement-Now.prompt.md` becomes `/coding-implement-now`. The subfolder belongs entirely to this library.

### Sync after editing, adding, or renaming prompts

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-VSCode-Prompts.ps1 -PruneStale
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-ClaudeCode-Prompts.ps1 -PruneStale
```

`-PruneStale` also removes installed copies whose source file was renamed, archived, or deleted. Both are available as VS Code tasks ("Sync to VS Code", "Sync to Claude Code").

### Uninstall

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Uninstall-VSCode-Prompts.ps1 -Channel Both
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Uninstall-ClaudeCode-Prompts.ps1
```

## Everyday workflow

Typical moment: an agent has just reviewed a feature, proposed a plan, or claimed an implementation is complete, and you want to respond with a disciplined, repeatable instruction instead of typing it fresh.

### In Copilot Chat (VS Code)

1. Type `/` in the chat input.
2. Pick the prompt by name, e.g. `/Coding-Implement-Now` or `/Review-Hardening-Pass` (the frontmatter description is shown next to each).
3. Press Enter — the prompt body is sent as your message. You can also run **Chat: Run Prompt** from the Command Palette to pick from a list.

Requires the prompt files feature (`chat.promptFiles`), which is enabled by default in current VS Code.

### In Claude Code

1. Type `/` in the chat input.
2. The library appears as commands like `/coding-implement-now`, `/review-senior-reviewer`, `/planning-approval-roadmap`, each with its description.
3. Select one and press Enter — the prompt body is injected as your message.

### Anywhere else

The files are plain Markdown: open one, copy the body, and paste it into any chat UI. For web-based tools, copy your highest-frequency prompts into a browser plugin or clipboard manager — but treat this repo as the source of truth and re-copy after edits.

### Highest-value defaults

- `/coding-approve-and-proceed` — plain approval, agent continues with judgment.
- `/planning-approval-roadmap` — approve and require roadmap/design documentation.
- `/review-hardening-pass` — approve but demand a stabilization and regression pass before "done".
- `/planning-approval-hardening-roadmap` — all of the above combined.

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the product intent, release goals, and pending work.

## Maintaining the library

1. Draft or refine prompts here, following the file format above and the naming pattern `<Category>-<Prompt-Name>.prompt.md` (see `00-governance/`).
2. Test them in real work.
3. Run the sync tasks so both chat surfaces pick up the change.
4. Retire superseded prompts into `99-archive/` rather than deleting them — archived files are excluded from installs unless you pass `-IncludeArchive`.

Keep one preferred default per major use case, and promote a prompt only after real use validates it.
