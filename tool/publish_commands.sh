#!/usr/bin/env bash
# Publishing is done by the Publish workflow when a version tag is pushed.
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
