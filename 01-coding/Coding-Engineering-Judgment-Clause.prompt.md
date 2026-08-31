# Engineering Judgment Clause

## Purpose
Allow implementation flexibility while preserving explicit guardrails and quality expectations.

## Use when
Use when you want the agent to adapt execution details without expanding scope or reducing rigor.

## Prompt
```text
Approved. Your findings are valid, and you may proceed.

Use engineering judgment in how best to carry this forward, but remain within the following constraints: preserve architectural consistency, maintain roadmap alignment, avoid unnecessary scope expansion, document meaningful design implications, and verify that the final implementation is complete and regression-safe before treating the work as done.
```

## Notes
Good for complex work where strict step-by-step prescription is counterproductive.
