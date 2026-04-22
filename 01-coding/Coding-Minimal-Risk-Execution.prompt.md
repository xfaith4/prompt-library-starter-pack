# Minimal-Risk Execution

## Purpose
Direct the agent to solve the problem with the smallest coherent safe change set.

## Use when
Use when a fix or feature should be delivered conservatively.

## Prompt
```text
Approved. Proceed, but optimize for minimal risk.

Implement this using the smallest coherent set of changes that fully solves the problem while preserving clarity and maintainability. Avoid unnecessary refactors, broad unrelated edits, or speculative redesign unless clearly justified by the implementation. Validate regression safety and document any follow-up opportunities separately rather than folding them into this change.
```

## Notes
Good for stabilizing mature codebases.
