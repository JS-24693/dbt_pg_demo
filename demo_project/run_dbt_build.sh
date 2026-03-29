#!/usr/bin/env bash
set -euo pipefail

# Auto-detect the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "============================================"
echo "Starting dbt build workflow ... "
echo "Project: demo_project"
echo "============================================"

# Run dbt build (models + tests + snapshots)
dbt build
exit_code=$?

echo "============================================"
echo "dbt build finished."
echo "Exit code: $exit_code"
echo "============================================"

# Pause equivalent (optional)
read -p "Press Enter to continue..."
