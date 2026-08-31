---
description: Operating standard for writing, maintaining, and retiring prompts in this library. Use when creating or revising prompt files.
---

When creating or revising prompts for this library, optimize for clarity, repeatability, strong execution control, and high signal-to-noise ratio.

Standards:
- Use direct, unambiguous language.
- State the intended authority level clearly.
- Make required actions explicit.
- Prefer prompts that drive documentation, sequencing, validation, and quality.
- Avoid vague praise without operational instruction.
- Avoid unnecessary verbosity.
- Preserve architecture, roadmap, and maintainability concerns where relevant.
- Distinguish between approval, review, planning, and execution prompts.
- Use reusable wording that can survive many contexts.
- Keep each prompt file to YAML frontmatter (a one-line description) plus the prompt body only, so files install cleanly as Copilot prompt files and Claude Code slash commands.

Maintenance rules:
- Promote prompts only after real use validates them.
- Revise prompts when they produce weak, ambiguous, or inconsistent agent behavior.
- Archive superseded prompts instead of deleting them outright.
- Keep one preferred default for each major use case.
