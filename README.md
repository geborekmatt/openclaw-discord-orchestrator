# OpenClaw Discord Orchestrator

A portfolio project documenting and building a real OpenClaw architecture where one Main agent is the only Discord interface and delegates work to persistent internal specialists.

## Project approach

This repository evolves in reviewable stages:

1. ✅ Mirror a fresh OpenClaw installation without publishing private runtime data.
2. ✅ Configure Main as the only Discord-facing agent.
3. ✅ Add persistent specialists such as Cody and Bizzy.
4. Add controlled internal delegation.
5. Add Main-owned, specialist-scoped ACP threads for coding work.
6. Add permission-based shared skills.

## Current milestone

This milestone adds Cody and Bizzy as persistent private specialists with separate identities, workspaces, instructions, and fictional memory examples. Main remains the only Discord-facing agent.

See [Main-only Discord setup](docs/MAIN-DISCORD-SETUP.md) and [Persistent specialists](docs/PERSISTENT-SPECIALISTS.md).

The reference includes OpenClaw's default workspace files, safe example configuration, and the common runtime directories present in a working installation. Generated or private areas—credentials, devices, Discord state, sessions, SQLite state, logs, approval sockets, Git metadata, and attestations—are represented with explanatory files rather than copied from a live installation.

## Baseline tree

```text
reference/.openclaw/
├── .env.example
├── acpx/README.md
├── agents/
│   ├── README.md
│   ├── main/
│   │   ├── README.md
│   │   └── sessions/README.md
│   ├── cody/
│   │   ├── README.md
│   │   ├── agent/README.md
│   │   └── sessions/README.md
│   └── bizzy/
│       ├── README.md
│       ├── agent/README.md
│       └── sessions/README.md
├── audit/README.md
├── completions/README.md
├── credentials/README.md
├── crestodian/README.md
├── devices/README.md
├── discord/README.md
├── identity/README.md
├── logs/README.md
├── media/README.md
├── npm/README.md
├── plugin-skills/README.md
├── service-env/README.md
├── skill-workshop/README.md
├── state/README.md
├── tmp/README.md
├── tui/README.md
├── workspace/
│   ├── AGENTS.md
│   ├── BOOTSTRAP.md
│   ├── HEARTBEAT.md
│   ├── IDENTITY.md
│   ├── SOUL.md
│   ├── TOOLS.md
│   ├── USER.md
│   ├── GIT-STATE.md
│   ├── openclaw-workspace-state.example.json
│   └── state/
│       ├── README.md
│       └── sessions/
│           ├── README.md
│           └── agent%3Acodex%3Aacp%3Aexample-session.example.json
├── workspace-cody/
│   ├── AGENTS.md
│   ├── HEARTBEAT.md
│   ├── IDENTITY.md
│   ├── MEMORY.example.md
│   ├── SOUL.md
│   ├── TOOLS.md
│   ├── USER.md
│   ├── GIT-STATE.md
│   ├── openclaw-workspace-state.example.json
│   └── memory/
│       ├── README.md
│       └── 2026-01-01.example.md
├── workspace-bizzy/
│   ├── AGENTS.md
│   ├── HEARTBEAT.md
│   ├── IDENTITY.md
│   ├── MEMORY.example.md
│   ├── SOUL.md
│   ├── TOOLS.md
│   ├── USER.md
│   ├── GIT-STATE.md
│   ├── openclaw-workspace-state.example.json
│   └── memory/
│       ├── README.md
│       └── 2026-01-01.example.md
├── workspace-attestations/README.md
├── exec-approvals.example.json
└── openclaw.example.json5
```

See [the baseline record](docs/FRESH-INSTALL-BASELINE.md) and [`PUBLIC_MANIFEST.yaml`](PUBLIC_MANIFEST.yaml) for provenance and publication rules.

## Safety

Never initialize this repository inside a live `~/.openclaw` directory and never copy the live directory recursively. The checked-in reference is built from a disposable baseline and reviewed examples.

## License

MIT
