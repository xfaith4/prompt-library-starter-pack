# Evaluate Against Full Roadmap

## Purpose
Prevent the agent from treating a feature as an automatic immediate priority.

## Use when
Use when approval is granted but sequencing still matters.

## Prompt
```text
Approved. I agree with the findings, assessment, and proposed direction.

Add this work to the roadmap and evaluate it alongside all other approved roadmap items, active priorities, technical debt, dependencies, and architectural goals. Do not treat this as an automatic immediate fix unless it is blocking, high risk, or materially impacts ongoing progress.

Proceed according to the unified roadmap and maintain continuity in the overall strategy, planning, and delivery sequence.
```

## Notes
Good when you want governance over agent eagerness.
