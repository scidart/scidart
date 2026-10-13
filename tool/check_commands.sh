#!/usr/bin/env bash
# Same checks the CI runs.
set -e

dart pub get
dart format --output=none --set-exit-if-changed .
dart analyze --fatal-infos
dart test
dart test -p chrome

# list outdated dependencies
dart pub outdated

# validate but do not publish the package
dart pub publish --dry-run
