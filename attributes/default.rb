
default['nsd3'] = {
  "server" => {
    #"ip-address" => ["1.2.3.4", "12fe::8ef0"],
    "hide-version" => false,
    "debug-mode" => false,
    "ip4-only" => false,
    "ip6-only" => false,
    "database" => "/var/lib/nsd3/nsd.db",
    "logfile" => "/var/log/nsd.log",
    "server-count" => 1,
    "tcp-count" => 10,
    "tcp-query-count" => 0,
    "tcp-timeout" => 120,
    "ipv4-edns-size" => 4096,
    "ipv6-edns-size" => 4096,
    "pidfile" => "/var/run/nsd3/nsd.pid",
    "port" => 53,
    "statistics" => 3600,
    #"chroot" => "/etc/nsd3",
    "username" => "nsd",
    "zonesdir" => "/etc/nsd3",
    "verbosity" => 0
  }
}
