---
description: Direct the agent to solve the problem with the smallest coherent, safe change set. Use when a fix should be delivered conservatively, such as in a mature codebase.
---

Approved. Proceed, but optimize for minimal risk.

Implement this using the smallest coherent set of changes that fully solves the problem while preserving clarity and maintainability. Avoid unnecessary refactors, broad unrelated edits, or speculative redesign unless clearly justified by the implementation. Validate regression safety and document any follow-up opportunities separately rather than folding them into this change.
