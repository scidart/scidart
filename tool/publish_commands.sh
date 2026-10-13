#!/usr/bin/env bash
# Releases are automatic when a new version is merged on master (see
# CONTRIBUTING.md). This script is the manual fallback: it pushes the tag,
# which starts the Publish workflow.
# Usage: tool/publish_commands.sh 0.0.3
set -e

version="$1"
if [ -z "$version" ]; then
  echo "usage: $0 <version>" >&2
  exit 1
fi
if ! grep -q "^version: $version$" pubspec.yaml; then
  echo "pubspec.yaml version is not $version" >&2
  exit 1
fi

dart pub publish --dry-run
git tag "v$version"
git push origin "v$version"
