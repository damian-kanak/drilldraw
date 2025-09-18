#!/bin/bash

# Setup Git Hooks for DrillDraw Development
# This script sets up pre-commit hooks to enforce development standards

set -e

echo "🔧 Setting up Git hooks for DrillDraw..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a Git repository"
    echo "Please run this script from the root of the DrillDraw repository"
    exit 1
fi

# Make sure the hooks directory exists
mkdir -p .git/hooks

# Copy the pre-commit hook
if [ -f ".git/hooks/pre-commit" ]; then
    echo "⚠️  Pre-commit hook already exists. Backing up..."
    cp .git/hooks/pre-commit .git/hooks/pre-commit.backup.$(date +%Y%m%d_%H%M%S)
fi

# The pre-commit hook should already be in place from our .cursorrules setup
if [ -f ".git/hooks/pre-commit" ]; then
    chmod +x .git/hooks/pre-commit
    echo "✅ Pre-commit hook is active and executable"
else
    echo "❌ Pre-commit hook not found. Please ensure .cursorrules setup is complete."
    exit 1
fi

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "⚠️  Warning: Flutter not found in PATH"
    echo "Make sure Flutter is installed and available in your PATH"
fi

# Check if Dart is available
if ! command -v dart &> /dev/null; then
    echo "⚠️  Warning: Dart not found in PATH"
    echo "Make sure Dart is available (usually comes with Flutter)"
fi

echo ""
echo "🎉 Git hooks setup complete!"
echo ""
echo "📋 What the pre-commit hook will check:"
echo "   ✅ Branch naming convention (feature/123-description)"
echo "   ✅ Code formatting (dart format)"
echo "   ✅ Flutter analysis (flutter analyze)"
echo "   ✅ Test execution (flutter test)"
echo ""
echo "💡 Tips:"
echo "   • Run 'dart format .' before committing to fix formatting"
echo "   • Run 'flutter test' to ensure all tests pass"
echo "   • Run 'flutter analyze' to check for code issues"
echo ""
echo "🚀 You're ready to contribute to DrillDraw!"