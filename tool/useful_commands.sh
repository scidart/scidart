#!/usr/bin/env bash

# generate doc
dartdoc

# install http server
pub global activate dhttpd

# open docs with http server
dhttpd --path doc/api

# flutter analyzer
flutter analyze

# dart analyzer
dartanalyzer lib test example

# format code
dartfmt -w lib test example

# validate but do not publish the package.
pub publish --dry-run

# pack and publish
publish package
pub publish