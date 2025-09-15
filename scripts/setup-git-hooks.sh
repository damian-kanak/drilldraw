#!/bin/bash

# Setup script for Git hooks
echo "🔧 Setting up Git hooks for DrillDraw..."

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Copy pre-commit hook
cp scripts/pre-commit-hook .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

echo "✅ Git hooks installed successfully!"
echo ""
echo "The pre-commit hook will now automatically:"
echo "  📝 Format your Dart code"
echo "  🔍 Run Flutter analysis"
echo "  🧪 Run tests"
echo ""
echo "If any check fails, the commit will be blocked until issues are resolved."
