# Main-only Discord setup

## Goal

Discord is the user's single entry point. Every permitted Discord message reaches Main, and Main owns the reply and any user-facing thread.

```text
Discord -> Main
```

## Main routing

The example configuration registers one agent named `main` and marks it as the default. The `bindings` list is empty, so Discord falls back to the default agent instead of routing directly to another agent.

Later milestones can add private specialists without giving them Discord bindings. Main will remain the public interface.

## Bot token

Copy [`reference/.openclaw/.env.example`](../reference/.openclaw/.env.example) to `~/.openclaw/.env` and set `DISCORD_BOT_TOKEN` to the bot token. Never commit the populated file.

The OpenClaw configuration uses an environment secret reference rather than storing the token directly:

```json
{
  "source": "env",
  "provider": "default",
  "id": "DISCORD_BOT_TOKEN"
}
```

## Allowlists

Replace `<DISCORD_USER_ID>` and `<DISCORD_GUILD_ID>` locally. Direct messages and server messages both use allowlist policies so the example is closed by default.

Do not publish real Discord user, guild, channel, application, or bot IDs.

## Validate

From the repository root, run:

```bash
./scripts/validate-reference.sh
```

When OpenClaw is installed, the script also checks the example configuration with OpenClaw's dry-run validator.
