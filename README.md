# chef-nsd3

[![Build Status](https://travis-ci.org/cmur2/chef-nsd3.png)](https://travis-ci.org/cmur2/chef-nsd3)

## Description

Installs the [Name Server Daemon](https://www.nlnetlabs.nl/projects/nsd/) and does basic configuration (no zone files!).

## Usage

Use `recipe[nsd3::default]` to get NSD installed (from packages) and configured from information found in `node['nsd3']`.

## Requirements

It should work on all OSes that provide a nsd3 package which currently are Debian and all derivates like Mint, Ubuntu, etc.

## Recipes

### default

TODO

## License

chef-nsd3 is licensed under the Apache License, Version 2.0. See LICENSE for more information.
