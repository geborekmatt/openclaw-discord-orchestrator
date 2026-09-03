#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
reference_root="$repo_root/reference/.openclaw"

required_paths=(
  ".env.example"
  "acpx/README.md"
  "agents/README.md"
  "agents/main/README.md"
  "agents/main/sessions/README.md"
  "audit/README.md"
  "completions/README.md"
  "credentials/README.md"
  "crestodian/README.md"
  "devices/README.md"
  "discord/README.md"
  "exec-approvals.example.json"
  "identity/README.md"
  "logs/README.md"
  "media/README.md"
  "npm/README.md"
  "openclaw.example.json5"
  "pirateship-debug-profile/README.md"
  "plugin-skills/README.md"
  "service-env/README.md"
  "skill-workshop/README.md"
  "state/README.md"
  "tmp/README.md"
  "tui/README.md"
  "workspace/AGENTS.md"
  "workspace/BOOTSTRAP.md"
  "workspace/HEARTBEAT.md"
  "workspace/IDENTITY.md"
  "workspace/SOUL.md"
  "workspace/TOOLS.md"
  "workspace/USER.md"
  "workspace/GIT-STATE.md"
  "workspace/openclaw-workspace-state.example.json"
  "workspace/state/README.md"
  "workspace/state/sessions/README.md"
  "workspace/state/sessions/agent%3Acodex%3Aacp%3Aexample-session.example.json"
  "workspace-attestations/README.md"
)

for relative_path in "${required_paths[@]}"; do
  if [[ ! -f "$reference_root/$relative_path" ]]; then
    echo "missing required reference file: $relative_path" >&2
    exit 1
  fi
done

if [[ $(<"$reference_root/.env.example") != "DISCORD_BOT_TOKEN=" ]]; then
  echo ".env.example must declare an empty DISCORD_BOT_TOKEN" >&2
  exit 1
fi

config_path="$reference_root/openclaw.example.json5"

if ! jq -e '
  (.agents.list | length) == 1 and
  .agents.list[0].id == "main" and
  .agents.list[0].default == true and
  .agents.list[0].name == "Main" and
  .bindings == [] and
  .channels.discord.enabled == true and
  .channels.discord.token == {
    "source": "env",
    "provider": "default",
    "id": "DISCORD_BOT_TOKEN"
  } and
  .channels.discord.dmPolicy == "allowlist" and
  .channels.discord.groupPolicy == "allowlist" and
  .channels.discord.allowFrom == ["<DISCORD_USER_ID>"] and
  (.channels.discord.guilds | keys) == ["<DISCORD_GUILD_ID>"] and
  .channels.discord.guilds["<DISCORD_GUILD_ID>"].users == ["<DISCORD_USER_ID>"]
' "$config_path" >/dev/null; then
  echo "example config must define one default Main agent and allowlisted Discord access" >&2
  exit 1
fi

if command -v openclaw >/dev/null 2>&1; then
  if ! DISCORD_BOT_TOKEN=validation-placeholder \
    openclaw config patch --file "$config_path" --replace-path agents.list --dry-run >/dev/null; then
    echo "OpenClaw rejected the example configuration" >&2
    exit 1
  fi
else
  echo "warning: OpenClaw is not installed; skipped schema validation" >&2
fi

expected_top_level_directories=(
  "acpx"
  "agents"
  "audit"
  "completions"
  "credentials"
  "crestodian"
  "devices"
  "discord"
  "identity"
  "logs"
  "media"
  "npm"
  "pirateship-debug-profile"
  "plugin-skills"
  "service-env"
  "skill-workshop"
  "state"
  "tmp"
  "tui"
  "workspace"
  "workspace-attestations"
)

if ! diff -u \
  <(printf '%s\n' "${expected_top_level_directories[@]}") \
  <(find "$reference_root" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort); then
  echo "reference top-level directory mirror is incomplete or contains an unexpected directory" >&2
  exit 1
fi

forbidden_names=(
  ".env"
  "openclaw.json"
  "exec-approvals.json"
  "MEMORY.md"
  "openclaw.sqlite"
)

for forbidden_name in "${forbidden_names[@]}"; do
  if find "$reference_root" -name "$forbidden_name" -print -quit | grep -q .; then
    echo "forbidden live-state filename found: $forbidden_name" >&2
    exit 1
  fi
done

if find "$reference_root" -type f \( -name '*.sqlite*' -o -name '*.jsonl' -o -name '*.log' -o -name '*.attested' \) -print -quit | grep -q .; then
  echo "generated runtime file found in public reference" >&2
  exit 1
fi

if find "$reference_root" -path '*/sessions/*.json' ! -name '*.example.json' -print -quit | grep -q .; then
  echo "real-looking session JSON found; only *.example.json files are allowed" >&2
  exit 1
fi

if rg -n --hidden '/Users/|/home/|gho_|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY|[0-9]{17,20}|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}' "$reference_root"; then
  echo "possible private identifier or secret found" >&2
  exit 1
fi

echo "reference validation passed"
