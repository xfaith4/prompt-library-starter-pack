# Explicit Acceptance Standard

## Purpose
Set explicit completion criteria the agent must satisfy before marking work complete.

## Use when
Use when you want implementation and review gated by a clear acceptance standard.

## Prompt
```text
Approved. Proceed, but do not mark the work complete until it satisfies the following standard:

- the intended feature or correction is fully implemented,
- the result is consistent with existing architecture and coding standards,
- no new bugs or regressions were introduced,
- key edge cases and failure paths were considered,
- and any follow-up items are explicitly documented rather than left implicit.

Use this standard to guide both implementation and final review.
```

## Notes
Excellent for reducing premature completion signals.
