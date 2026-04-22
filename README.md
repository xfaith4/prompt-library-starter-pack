# Prompt Library Starter Pack

A structured prompt library for repeatable, high-value work in coding, review, planning, writing, and session continuity.

## Recommended use model

- Keep this folder in a Git-tracked location and treat it as the canonical source.
- Store only your highest-frequency prompts in a browser plugin or clipboard manager.
- Revise prompts in this library first, then copy stable versions into quick-access tools.

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

