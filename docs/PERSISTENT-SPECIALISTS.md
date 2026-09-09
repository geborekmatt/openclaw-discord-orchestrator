# Persistent specialists

## Goal

Main remains the only Discord-facing agent while Cody and Bizzy keep separate identities, instructions, memory, and working context.

```text
Discord -> Main
            |-- Cody  (engineering)
            `-- Bizzy (business)
```

This milestone registers the specialists and defines their durable workspaces. Permissioned agent-to-agent delegation is added separately.

## Cody

Cody is the software-engineering specialist. Cody's workspace contains engineering instructions, identity, operating boundaries, tool notes, and fictional memory examples.

Suggested responsibilities include development, debugging, architecture, tests, repository maintenance, OpenClaw configuration, integrations, and automation.

## Bizzy

Bizzy is the business-management specialist. Bizzy's workspace contains business instructions, identity, operating boundaries, tool notes, and fictional memory examples.

Suggested responsibilities include strategy, planning, research, operations, prioritization, requirements, metrics, and business-side review.

## Persistence

Each specialist has a stable agent ID and workspace path. OpenClaw can preserve the specialist's private sessions and the workspace can preserve curated memory between tasks.

Real `MEMORY.md`, dated memory notes, session transcripts, model state, and workspace Git metadata remain private. The repository includes only placeholders and clearly fictional examples.

## Discord isolation

The public configuration keeps `bindings` empty and Main remains the default agent. Cody and Bizzy therefore have no direct Discord route.

Run the repository validator to confirm the three-agent registry, workspace separation, Main-only default, and absence of private state:

```bash
./scripts/validate-reference.sh
```
