# Fresh-install baseline

## Provenance

- OpenClaw version: `2026.7.1-2` (`0790d9f`)
- Capture date: `2026-09-03`
- Platform: macOS on arm64
- Source: `openclaw setup --baseline`

The baseline was written to a temporary OpenClaw state directory rather than the user's configured workspace:

```bash
OPENCLAW_STATE_DIR=<TEMP_STATE_DIR> \
  openclaw setup --baseline \
  --workspace <TEMP_STATE_DIR>/workspace \
  --json
```

## Generated structure

```text
<STATE_DIR>/
├── agents/main/sessions/
├── exec-approvals.json
├── logs/config-audit.jsonl
├── openclaw.json
├── state/openclaw.sqlite
├── workspace/
│   ├── .git/
│   ├── AGENTS.md
│   ├── BOOTSTRAP.md
│   ├── HEARTBEAT.md
│   ├── IDENTITY.md
│   ├── SOUL.md
│   ├── TOOLS.md
│   ├── USER.md
│   └── openclaw-workspace-state.json
└── workspace-attestations/<hash>.attested
```

Private and generated files are represented in the repository with examples or explanatory documents. Auto-managed `meta.lastTouchedVersion` and `meta.lastTouchedAt` values are omitted from the reusable configuration example. No live OpenClaw state was used as publishable source material.

## Runtime directory mirror

The setup command creates only the minimum bootstrap structure. A working OpenClaw installation creates additional top-level directories as features are initialized. The repository includes empty documented representations of these directories so its layout remains recognizable without publishing runtime data:

```text
acpx/                       agents/        audit/
completions/                credentials/   crestodian/
devices/                    discord/       identity/
logs/                       media/         npm/
skill-workshop/             state/         tmp/
tui/                        workspace/     workspace-attestations/
```

Specialist workspaces such as `workspace-cody/` and `workspace-bizzy/` are not part of the installation baseline. They are added separately as part of this project's orchestration architecture.
