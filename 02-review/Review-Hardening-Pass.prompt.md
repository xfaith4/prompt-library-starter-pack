# Hardening Pass

## Purpose
Require a post-implementation stabilization and regression review.

## Use when
Use when a feature looks correct but should not yet be considered complete.

## Prompt
```text
Before considering the work complete, perform a full code review and hardening pass to verify that the feature has been fully implemented as intended, that no new bugs, regressions, or edge-case failures were introduced, and that the implementation is stable and maintainable. Refer to the architectural patterns and coding standards already present in the codebase (e.g., folder structure, naming conventions, error handling patterns) as the baseline for consistency checks.

Address any issues discovered during this review before marking the work complete. For each issue found, describe the problem, its location, and the fix applied. If no issues are found, explicitly state that the hardening pass is complete and the implementation is stable.
```

## Notes
Excellent for the final pass after agent enthusiasm has outrun verification.
