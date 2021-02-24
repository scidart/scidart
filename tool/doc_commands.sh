#!/usr/bin/env bash

# generate doc
dartdoc

# open docs with http server
dhttpd --path doc/api