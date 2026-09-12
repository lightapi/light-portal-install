#!/usr/bin/env bash
# Usage: bash verify-agent-image.sh docker docker compose [compose options...]
set -euo pipefail
runtime="$1"
shift
config=$("$@" config --format json)
images=$(printf '%s' "$config" | python3 -c '
import json, sys
services = json.load(sys.stdin)["services"]
print("\n".join(sorted({services[name]["image"] for name in
    [name for name in services if name == "light-agent" or name.startswith("light-agent-")]})))
')
while IFS= read -r image; do
    [[ -n "$image" ]] || { echo "Missing agent image selection" >&2; exit 1; }
    if ! "$runtime" image inspect "$image" >/dev/null 2>&1; then
        "$runtime" pull "$image"
    fi
    capability=$("$runtime" image inspect --format '{{ index .Config.Labels "io.lightapi.agent.session-lifecycle" }}' "$image" 2>/dev/null || true)
    if [[ "$capability" != "1" ]]; then
        echo "Agent image $image lacks session-lifecycle capability 1. Build/publish the corrected light-agent image and select it in RELEASE_IMAGE_ENV_FILE before deploying. Existing services were not stopped." >&2
        exit 1
    fi
    echo "Verified agent session-lifecycle capability: $image"
done <<< "$images"

claude_image=$(printf '%s' "$config" | python3 -c 'import json,sys; print(json.load(sys.stdin)["services"].get("light-agent-claude-personal",{}).get("image",""))')
if [[ -n "$claude_image" ]]; then
    capability=$("$runtime" image inspect --format '{{ index .Config.Labels "io.lightapi.agent.claude-personal" }}' "$claude_image")
    [[ "$capability" == "phase2" ]] || { echo "Claude Agent image lacks the qualified local admission contract" >&2; exit 1; }
fi
