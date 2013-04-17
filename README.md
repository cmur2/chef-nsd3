# chef-nsd3

[![Build Status](https://travis-ci.org/cmur2/chef-nsd3.png)](https://travis-ci.org/cmur2/chef-nsd3)

## Description

Installs the [Name Server Daemon](https://www.nlnetlabs.nl/projects/nsd/) and does basic configuration including the copying of BIND compatible zone files.

## Usage

Use `recipe[nsd3::default]` to get NSD installed (from packages) and configured from information found in `node['nsd3']`. Use `recipe[nsd3::logrotate]` to get logrotate configuration for NSDs logfile.

## Requirements

It should work on all OSes that provide a nsd3 (tested against NSD 3.2.5) package which currently are Debian and all derivates like Mint, Ubuntu, etc.

## Recipes

### default

Configures NSD, rebuilds zone files and starts the service from the options found in `node["nsd3"]`. There are two major sections: `node["nsd3"]["server"]` for the server options and `node["nsd3"]["zones"]` including a hash of zone configuration entries. To specify the cookbook name where the zone files are load from use `node["nsd3"]["file_cookbook"]`.

For the server options you can specify any key listed on the man page and will be used verbatim in the configuration file. Each option value can be of several types:

* `true`, `false`: Use for boolean values, they result in `yes` and `no`.
* `Integer`: Direct mapping of integers.
* `String`: The string is pasted into the file without modification. So escaping like `"/my/path with spaces/conf"` is possible.
* `''`: Special case of the String type. Designed to ignore any presetted values and let NSD choose it's own default value.

For the zones one will specify a hash containing `zone_name => zone_config` mappings where the `zone_name` directly goes as name for NSD and the `zone_config` hash is subject to the same rules as the server options. It has to contain at least the `zonefile` option as it's required by NSD. For other options see the man page.

### logrotate

Adds a NSD3 specific logrotate configuration when logrotate cookbook is found. No attributes needed.

## License

chef-nsd3 is licensed under the Apache License, Version 2.0. See LICENSE for more information.
