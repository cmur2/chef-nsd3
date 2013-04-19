name             "nsd3"
maintainer       "Christian Nicolai"
maintainer_email "cn@mycrobase.de"
license          "Apache 2.0"
description      "Installs NSD and does basic configuration including the copying of BIND compatible zone files."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

suggests "logrotate" # for nsd3::logrotate

supports "debian"
