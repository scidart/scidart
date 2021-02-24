#!/usr/bin/env bash

# flutter analyzer
#flutter analyze

# dart analyzer
dartanalyzer lib test example

# format code
dartfmt -w lib test example

# update packages
pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides

# validate but do not publish the package.
pub publish --dry-run