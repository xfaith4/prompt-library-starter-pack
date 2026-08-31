# Prompt Library Starter Pack

A structured prompt library for repeatable, high-value work in coding, review, planning, writing, and session continuity.

## Recommended use model

- Keep this folder in a Git-tracked location and treat it as the canonical source.
- Store only your highest-frequency prompts in a browser plugin or clipboard manager.
- Revise prompts in this library first, then copy stable versions into quick-access tools.

## Install into VS Code Prompt Library

VS Code supports user-level prompt files under the user profile prompt directory.
This repo includes scripts that install all `.prompt.md` files into that global location so prompts are available in workflow without opening this repository.

### Install for VS Code Stable

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-VSCode-Prompts.ps1
```

### Install for VS Code Insiders

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-VSCode-Prompts.ps1 -Channel Insiders
```

### Install for both Stable and Insiders

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-VSCode-Prompts.ps1 -Channel Both
```

### Sync and remove stale installed prompts

Use this when prompts were renamed or removed in this repo and you want the installed VS Code copy to match exactly.

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-VSCode-Prompts.ps1 -PruneStale
```

### Uninstall

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Uninstall-VSCode-Prompts.ps1 -Channel Both
```

### Run from VS Code Tasks

This repo includes ready tasks in [.vscode/tasks.json](.vscode/tasks.json):

- Prompt Library: Install to VS Code
- Prompt Library: Sync to VS Code (Prune Stale)

Use Run Task in VS Code and select one of those entries.

## Folder layout

- `00-governance/` — standards, naming, maintenance rules
- `01-coding/` — implementation and engineering prompts
- `02-review/` — review, hardening, audit, and quality prompts
- `03-planning/` — roadmap, sequencing, strategy, documentation prompts
- `04-writing/` — rewrite, summarization, and communication prompts
- `05-session/` — session continuity and wrap-up prompts
- `99-archive/` — retired or superseded prompts

## File naming standard

Use:

`<Category>-<Prompt-Name>.prompt.md`

Examples:

- `Coding-Implement-Now.prompt.md`
- `Review-Senior-Reviewer.prompt.md`
- `Planning-Approval-Hardening-Roadmap.prompt.md`

## Prompt file format

Each file should contain:

1. **Title**
2. **Purpose**
3. **Use when**
4. **Prompt**
5. **Notes**

## Suggested workflow

1. Draft or refine prompts here.
2. Test them in real work.
3. Promote the best ones into your browser plugin or daily-use shortlist.
4. Retire stale prompts into `99-archive/` rather than deleting them.

## Search tips in VS Code

Search by:

- `Approved.`
- `production-readiness`
- `roadmap`
- `hardening`
- `session summary`
- `senior reviewer`

## Git advice

This library works best as:

- a folder inside your main engineering repo, or
- a separate private repo named something like `prompt-library`
