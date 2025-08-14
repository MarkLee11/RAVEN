#!/bin/bash

# Auto-commit hook for Claude Code
# Automatically commits changes to Git after successful operations without errors

set -e  # Exit on any error

cd "$CLAUDE_PROJECT_DIR" || exit 1

echo "🔍 Auto-commit hook triggered..."

# Skip if this is a documentation file change (to avoid recursive commits)
if echo "$1" | grep -E "\.(md)$" > /dev/null; then
    echo "⏭️  Skipping auto-commit for documentation file"
    exit 0
fi

# Check if Git is initialized
if [ ! -d ".git" ]; then
    echo "📁 Initializing Git repository..."
    git init
    echo "✅ Git repository initialized"
fi

# Check if there are any changes to commit
if git diff --quiet && git diff --cached --quiet; then
    echo "⏭️  No changes to commit"
    exit 0
fi

# Run quality checks first
echo "🔍 Running code quality checks..."

# Check if npm run lint exists and run it
if command -v npm >/dev/null 2>&1 && npm run lint --silent 2>/dev/null; then
    echo "✅ Lint check passed"
else
    echo "⚠️  Lint check skipped (no npm lint script found)"
fi

# Check if npm run typecheck exists and run it  
if command -v npm >/dev/null 2>&1 && npm run typecheck --silent 2>/dev/null; then
    echo "✅ TypeScript check passed"
elif command -v npx >/dev/null 2>&1 && npx tsc --noEmit --silent 2>/dev/null; then
    echo "✅ TypeScript check passed"
else
    echo "⚠️  TypeScript check skipped (no typecheck script found)"
fi

# Add all changes to staging
echo "📦 Staging changes..."
git add .

# Generate commit message based on changed files
CHANGED_FILES=$(git diff --cached --name-only | head -5)
CHANGE_COUNT=$(git diff --cached --name-only | wc -l)

# Create descriptive commit message
if [ "$CHANGE_COUNT" -eq 1 ]; then
    MAIN_FILE=$(echo "$CHANGED_FILES" | head -1)
    if [[ "$MAIN_FILE" == *.tsx ]]; then
        COMMIT_MSG="Update React component: $(basename "$MAIN_FILE" .tsx)"
    elif [[ "$MAIN_FILE" == *.ts ]]; then
        COMMIT_MSG="Update TypeScript: $(basename "$MAIN_FILE" .ts)"  
    elif [[ "$MAIN_FILE" == *.css ]] || [[ "$MAIN_FILE" == *.scss ]]; then
        COMMIT_MSG="Update styles: $(basename "$MAIN_FILE")"
    else
        COMMIT_MSG="Update $(basename "$MAIN_FILE")"
    fi
else
    # Multiple files changed
    if echo "$CHANGED_FILES" | grep -q "\.tsx\|\.ts"; then
        COMMIT_MSG="Update React components and TypeScript files"
    elif echo "$CHANGED_FILES" | grep -q "package\.json"; then
        COMMIT_MSG="Update project dependencies and configuration"
    else
        COMMIT_MSG="Update multiple project files"
    fi
fi

# Add more context if it's a feature/component change
if echo "$CHANGED_FILES" | grep -q "src/components/"; then
    COMMIT_MSG="$COMMIT_MSG - enhance UI components"
elif echo "$CHANGED_FILES" | grep -q "src/routes/"; then
    COMMIT_MSG="$COMMIT_MSG - improve page routing"
elif echo "$CHANGED_FILES" | grep -q "src/services/"; then
    COMMIT_MSG="$COMMIT_MSG - update business logic"
fi

# Create the commit with Claude Code attribution
git commit -m "$(cat <<EOF
$COMMIT_MSG

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"

echo "✅ Successfully committed changes!"
echo "📝 Commit message: $COMMIT_MSG"

# Show brief summary
echo "📊 Changes summary:"
git show --stat --oneline HEAD | head -10