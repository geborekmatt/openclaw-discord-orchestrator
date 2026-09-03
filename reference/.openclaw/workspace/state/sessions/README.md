# ACP session state

Files in this directory describe resumable ACP sessions. Their URL-encoded filenames can identify the agent, runtime, and session UUID, while their contents can include machine paths, process IDs, messages, model settings, and usage data.

Never publish a real session file. The adjacent `*.example.json` file is fictional and exists only to document the shape of the state.
