#!/bin/bash

# Cross-platform documentation update hook for Claude Code
# This script runs after successful Write/Edit operations

cd "$CLAUDE_PROJECT_DIR" || exit 1

# Check if this is a code change (not a documentation file itself)
if echo "$1" | grep -E "\.(md|txt)$" > /dev/null; then
    echo "Skipping doc update for documentation file change"
    exit 0
fi

# Run the documentation generator
echo "🔄 Updating project documentation..."

if command -v node >/dev/null 2>&1; then
    node .claude/hooks/update-docs.js
    echo "✅ Documentation updated successfully"
else
    echo "❌ Node.js not found - skipping documentation update"
    exit 1
fi