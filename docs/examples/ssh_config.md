## ssh_config provider

This is a custom type and provider supplied by `augeasproviders`.

### manage simple entry

    ssh_config { "ForwardAgent":
      ensure => present,
      value  => "yes",
    }

### manage array entry

    ssh_config { "SendEnv":
      ensure => present,
      value  => ["LC_*", "LANG"],
    }

### manage entry for a specific host

    ssh_config { "X11Forwarding":
      ensure    => present,
      host      => "example.net",
      value     => "yes",
    }

### manage entries with same name for different hosts

    ssh_config { "ForwardAgent global":
      ensure => present,
      key    => "ForwardAgent",
      value  => "no",
    }

    ssh_config { "ForwardAgent on example.net":
      ensure    => present,
      key       => "ForwardAgent",
      host      => "example.net",
      value     => "yes",
    }

### delete entry

    ssh_config { "HashKnownHosts":
      ensure => absent,
    }

    ssh_config { "BatchMode":
      ensure    => absent,
      host      => "example.net",
    }

### manage entry in another ssh_config location

    ssh_config { "CheckHostIP":
      ensure => present,
      value  => "yes",
      target => "/etc/ssh/another_sshd_config",
    }
