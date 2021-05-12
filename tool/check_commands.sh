#!/usr/bin/env bash

# flutter analyzer
#flutter analyze

# dart analyzer
dartanalyzer lib test example
dart analyze

# format code
dartfmt -w lib test example

# update packages
pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides

# validate but do not publish the package.
pub publish --dry-run

# sequence useful
dartfmt -w lib test example
dartanalyzer lib test example
pub publish --dry-run