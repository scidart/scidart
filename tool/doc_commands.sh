#!/usr/bin/env bash

# generate doc
dart doc

# open docs with http server
dart pub global run dhttpd --path doc/api
