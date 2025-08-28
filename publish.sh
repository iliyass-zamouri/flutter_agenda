#!/bin/bash

# Flutter Agenda Publish Script for Unix/macOS
# Usage: ./publish.sh "commit message"

set -e  # Exit on any error

echo "🚀 Flutter Agenda Publishing Script"
echo "=================================="

# Check if commit message is provided
if [ -z "$1" ]; then
    echo "❌ Error: Please provide a commit message"
    echo "Usage: ./publish.sh \"commit message\""
    exit 1
fi

COMMIT_MESSAGE="$1"

# Prompt for changelog update
echo ""
read -p "📝 Did you add the new version update to CHANGELOG.md? (y/[n]): " CHANGELOG

if [[ ! "$CHANGELOG" =~ ^[Yy]$ ]]; then
    echo "❌ Please update the CHANGELOG.md first"
    exit 1
fi

# Prompt for pubspec version update
echo ""
read -p "📦 Did you update the new version in pubspec.yaml? (y/[n]): " PUBSPEC

if [[ ! "$PUBSPEC" =~ ^[Yy]$ ]]; then
    echo "❌ Please update the pubspec.yaml version first"
    exit 1
fi

echo ""
echo "✅ All checks passed! Starting publish process..."
echo ""

# Add all changes to git
echo "📁 Adding files to git..."
git add .

# Commit changes
echo "💾 Committing changes with message: '$COMMIT_MESSAGE'"
git commit -m "$COMMIT_MESSAGE"

# Push to origin main
echo "🚀 Pushing to origin main..."
git push origin main

# Publish to pub.dev
echo "📤 Publishing to pub.dev..."
flutter pub publish

echo ""
echo "🎉 Publishing completed successfully!"
echo "📋 Version $(grep '^version:' pubspec.yaml | sed 's/version: //') has been published"
echo ""
echo "🔗 Check your package at: https://pub.dev/packages/flutter_agenda"
