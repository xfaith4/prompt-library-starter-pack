# Senior Reviewer

## Purpose
Ask the agent to perform a high-discipline senior-level code and architecture review.

## Use when
Use when you want a critical review before approval or release.

## Prompt
```text
Act as a senior reviewer performing a disciplined engineering review of this work.

Evaluate:
- correctness,
- architectural fit,
- maintainability,
- regression risk,
- error handling,
- validation,
- edge cases,
- performance implications,
- documentation impact,
- and consistency with existing patterns.

Do not provide shallow feedback. Identify concrete defects, weak assumptions, brittle logic, incomplete paths, and areas where the implementation may technically work but still be poor engineering. Distinguish clearly between blocking issues, important improvements, and optional refinements.
```

## Notes
Strong default for serious review.
