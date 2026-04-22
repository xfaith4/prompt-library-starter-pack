# Coder's Dream Prompt Pack

A reusable prompt library for directing coding agents with clear approval, roadmap discipline, review rigor, and execution quality.

## How to use this pack

Use these prompts as ready-made response templates when an agent has reviewed a feature, proposed a plan, or completed an implementation that you want to approve, refine, document, or harden.

These prompts are written to drive:

- clear next actions,
- stronger architectural continuity,
- better roadmap discipline,
- explicit hardening and regression review,
- less reactive feature-by-feature drift.

---

## 1. Approval

**Use when:** you agree with the findings and want the agent to continue.

```text
Approved. Your findings are valid, and we are aligned on the assessment, recommended direction, and overall intent.

Proceed with the next appropriate actions based on your review. Maintain consistency with the application’s architecture, standards, and existing implementation patterns. Where judgment is required, optimize for correctness, maintainability, and long-term clarity rather than short-term convenience.
```

---

## 2. Approval + Roadmap

**Use when:** you agree, but want the work formally captured in roadmap/design documentation before or alongside execution.

```text
Approved. Your findings are valid, and we are aligned on the assessment, suggested prioritization, and overall direction.

Please add these findings, recommendations, dependencies, and any design implications to the application roadmap and supporting design documentation. Ensure the roadmap reflects both the immediate relevance of this work and its relationship to the broader product plan.

Proceed in a way that preserves continuity of strategy, architecture, and execution across the application as a whole.
```

---

## 3. Approval + Hardening

**Use when:** the feature looks good, but you want a rigorous validation and stabilization pass before considering it complete.

```text
Approved in principle. This appears to be a strong and worthwhile improvement.

Before considering the work complete, perform a full code review and hardening pass to verify that the feature has been fully implemented as intended, that no new bugs, regressions, or edge-case failures were introduced, and that the implementation is stable, maintainable, and consistent with the application's existing architecture and standards.

Address any issues discovered during this review before marking the work complete.
```

---

## 4. Approval + Hardening + Roadmap

**Use when:** you want both documentation discipline and a full quality pass, without treating the feature as an isolated one-off.

```text
Approved. Your findings are valid, and we are aligned on the direction and overall value of this work.

Please document the findings, recommendations, dependencies, and design implications in the application roadmap and supporting design documentation. Treat this work as part of the broader approved plan rather than as an isolated change.

Before considering the work complete, perform a full code review and hardening pass to verify implementation completeness, regression safety, architectural consistency, and production readiness. Resolve any issues discovered during that review, then proceed according to the broader roadmap and approved sequencing.
```

---

## 5. Approval + Evaluate Against Full Roadmap

**Use when:** you do not want the agent to jump straight into this item.

```text
Approved. I agree with the findings, assessment, and proposed direction.

Add this work to the roadmap and evaluate it alongside all other approved roadmap items, active priorities, technical debt, dependencies, and architectural goals. Do not treat this as an automatic immediate fix unless it is blocking, high risk, or materially impacts ongoing progress.

Proceed according to the unified roadmap and maintain continuity in the overall strategy, planning, and delivery sequence.
```

---

## 6. Approval + Implement Now

**Use when:** you want immediate execution, not just documentation and evaluation.

```text
Approved. Your findings and recommended direction are valid.

Proceed with implementation now. As you do, preserve consistency with existing architecture, standards, and roadmap intent. Use sound engineering judgment, keep the change set disciplined, and document any important design decisions, tradeoffs, and follow-up items as part of the implementation.
```

---

## 7. Approval + Review Before Implementation

**Use when:** you agree with the plan, but want one more careful pass before code changes begin.

```text
Approved in direction, but do not begin implementation yet.

First, perform a careful review of the proposed solution for architectural fit, dependency impact, edge cases, rollback risk, and interaction with existing roadmap items. Refine the plan where needed, document the final intended approach, and only then proceed with implementation using the validated plan.
```

---

## 8. Approval + Minimal-Risk Execution

**Use when:** you want the agent to favor safe incremental changes.

```text
Approved. Proceed, but optimize for minimal risk.

Implement this using the smallest coherent set of changes that fully solves the problem while preserving clarity and maintainability. Avoid unnecessary refactors, broad unrelated edits, or speculative redesign unless clearly justified by the implementation. Validate regression safety and document any follow-up opportunities separately rather than folding them into this change.
```

---

## 9. Approval + Fix and Report Residual Issues

**Use when:** you want execution plus explicit identification of what remains imperfect.

```text
Approved. Proceed with the work and resolve the issues identified in your review.

As part of execution, also identify any remaining limitations, deferred improvements, technical debt, or architectural concerns that should not be silently carried forward. Correct what is appropriate within scope, and document any justified follow-up items clearly so they can be tracked on the roadmap rather than lost in implementation.
```

---

## 10. Approval + Production-Readiness Standard

**Use when:** you want a higher bar than “works on my machine.”

```text
Approved. Proceed to completion with a production-readiness standard.

Do not consider the work complete merely because the feature appears functional. Verify correctness, resilience, error handling, validation, edge-case behavior, maintainability, and consistency with existing application standards. Harden any weak points discovered during implementation and review, and ensure the final result is suitable for reliable long-term use.
```

---

## 11. Approval + Documentation-First

**Use when:** you want design clarity locked in before implementation spreads.

```text
Approved. Before broader execution, update the roadmap and relevant design documentation to reflect the intended change, its purpose, its expected behavior, and any architectural implications.

Once the documentation accurately represents the approved direction, proceed with implementation in alignment with that documented plan. Keep code, roadmap, and design intent synchronized throughout the work.
```

---

## 12. Approval + Strategic Continuity

**Use when:** you want to reinforce that the agent is working on an application, not a pile of isolated features.

```text
Approved. Your findings are sound, and we are aligned on direction.

Proceed in a way that preserves strategic continuity across the application. Evaluate this work in relation to existing roadmap commitments, architectural direction, design consistency, and long-term maintainability. Avoid feature-by-feature drift, and ensure that implementation choices support the coherence of the overall product rather than just the local improvement.
```

---

## 13. Approval + Explicit Acceptance Standard

**Use when:** you want the agent to self-check against completion criteria.

```text
Approved. Proceed, but do not mark the work complete until it satisfies the following standard:

- the intended feature or correction is fully implemented,
- the result is consistent with existing architecture and coding standards,
- no new bugs or regressions were introduced,
- key edge cases and failure paths were considered,
- and any follow-up items are explicitly documented rather than left implicit.

Use this standard to guide both implementation and final review.
```

---

## 14. Approval + Hardening + Deferred Sequencing

**Use when:** you like the change, but still want it held within roadmap order.

```text
Approved. This appears to be a meaningful improvement, and we are aligned on the direction.

Document the work in the roadmap and design materials, then perform a full review and hardening pass to validate completeness, regression safety, and implementation quality. Do not assume this must be executed immediately as a standalone priority. Instead, place it within the broader approved roadmap and implement it at the correct point in the overall sequence unless urgency or risk clearly justifies acceleration.
```

---

## 15. Approval + Engineering Judgment Clause

**Use when:** you want to give the agent flexibility without losing control.

```text
Approved. Your findings are valid, and you may proceed.

Use engineering judgment in how best to carry this forward, but remain within the following constraints: preserve architectural consistency, maintain roadmap alignment, avoid unnecessary scope expansion, document meaningful design implications, and verify that the final implementation is complete and regression-safe before treating the work as done.
```

---

# Default Four

If you want the shortest high-value core set, use these four most often.

## Default Approval

```text
Approved. Your findings are valid, and we are aligned on the assessment, recommended direction, and overall intent.

Proceed with the next appropriate actions based on your review. Maintain consistency with the application’s architecture, standards, and existing implementation patterns. Where judgment is required, optimize for correctness, maintainability, and long-term clarity rather than short-term convenience.
```

## Default Approval + Roadmap

```text
Approved. Your findings are valid, and we are aligned on the assessment, suggested prioritization, and overall direction.

Please add these findings, recommendations, dependencies, and any design implications to the application roadmap and supporting design documentation. Ensure the roadmap reflects both the immediate relevance of this work and its relationship to the broader product plan.

Proceed in a way that preserves continuity of strategy, architecture, and execution across the application as a whole.
```

## Default Approval + Hardening

```text
Approved in principle. This appears to be a strong and worthwhile improvement.

Before considering the work complete, perform a full code review and hardening pass to verify that the feature has been fully implemented as intended, that no new bugs, regressions, or edge-case failures were introduced, and that the implementation is stable, maintainable, and consistent with the application's existing architecture and standards.

Address any issues discovered during this review before marking the work complete.
```

## Default Approval + Hardening + Roadmap

```text
Approved. Your findings are valid, and we are aligned on the direction and overall value of this work.

Please document the findings, recommendations, dependencies, and design implications in the application roadmap and supporting design documentation. Treat this work as part of the broader approved plan rather than as an isolated change.

Before considering the work complete, perform a full code review and hardening pass to verify implementation completeness, regression safety, architectural consistency, and production readiness. Resolve any issues discovered during that review, then proceed according to the broader roadmap and approved sequencing.
```

---

# Suggested File Names if Split Into Individual Prompt Files

- `Approval.prompt.txt`
- `Approval-Roadmap.prompt.txt`
- `Approval-Hardening.prompt.txt`
- `Approval-Hardening-Roadmap.prompt.txt`
- `Approval-Evaluate-Against-Roadmap.prompt.txt`
- `Approval-Implement-Now.prompt.txt`
- `Approval-Review-Before-Implementation.prompt.txt`
- `Approval-Minimal-Risk.prompt.txt`
- `Approval-Production-Readiness.prompt.txt`

---

# Recommended Storage Approaches

## Good: Browser plugin prompt library

Your current approach makes sense for:

- quick recall,
- cross-site usage,
- lightweight add/remove workflows,
- prompts you paste into web UIs often.

## Better for engineering workflows: VS Code prompt library

Yes — this pack is very well suited to a VS Code-based prompt library.

### Why VS Code fits well

- prompts live beside your repos and project docs,
- they are searchable,
- they can be versioned with Git,
- they are easier to refine over time,
- they can be grouped by domain such as coding, review, writing, planning, and reporting,
- multi-file organization scales better than plugin-only storage.

### Suggested folder structure

```text
.prompt-library/
  coding/
    Approval.prompt.md
    Approval-Roadmap.prompt.md
    Approval-Hardening.prompt.md
    Approval-Hardening-Roadmap.prompt.md
  writing/
    Revise-User-Writing.prompt.md
    Cover-Letter.prompt.md
  review/
    Senior-Reviewer.prompt.md
    Session-Summary.prompt.md
  planning/
    Roadmap-Planning.prompt.md
    Design-Review.prompt.md
```

### Strong hybrid model

A good long-term setup is:

- **browser plugin** for fastest paste-access,
- **VS Code folder** as the canonical master library,
- **Git repo** for version history and cleanup.

That gives you speed and durability.

---

# Recommended Next Step

Use this Markdown pack as the canonical source in VS Code, then copy your most-used prompts into the browser plugin for immediate access.

That usually works better than trying to make the plugin your only source of truth.

---

# Optional Expansion Categories

When you build this library out further, these categories are usually high value:

- coding approvals
- bug triage
- architecture review
- roadmap planning
- documentation cleanup
- refactor control
- test-generation requests
- production hardening
- executive summary generation
- writing and rewriting

