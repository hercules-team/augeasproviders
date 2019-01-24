## pam provider

This is a custom type and provider supplied by `augeasproviders`.

### manage simple entry

    pam { "Set sss entry to system-auth auth":
      ensure    => present,
      service   => 'system-auth',
      type      => 'auth',
      control   => 'sufficient',
      module    => 'pam_sss.so',
      arguments => 'use_first_pass',
      position  => 'before module pam_deny.so',
    }

### manage same entry but with Augeas xpath

    pam { "Set sss entry to system-auth auth":
      ensure    => present,
      service   => 'system-auth',
      type      => 'auth',
      control   => 'sufficient',
      module    => 'pam_sss.so',
      arguments => 'use_first_pass',
      position  => 'before *[type="auth" and module="pam_deny.so"]',
    }

### delete entry

    pam { "Remove sss auth entry from system-auth":
      ensure  => absent,
      service => 'system-auth',
      type    => 'auth',
      module  => 'pam_sss.so',
    }

### delete all references to module in file

    pam { "Remove all pam_sss.so from system-auth":
      ensure  => absent,
      service => 'system-auth',
      module  => 'pam_sss.so',
    }

### manage entry in another pam service

    pam { "Set cracklib limits in password-auth":
      ensure    => present,
      service   => 'password-auth',
      type      => 'password',
      module    => 'pam_cracklib.so',
      arguments => ['try_first_pass','retry=3', 'minlen=10'],
    }

### manage entry like previous but in classic pam.conf

    pam { "Set cracklib limits in password-auth":
      ensure    => present,
      service   => 'password-auth',
      type      => 'password',
      module    => 'pam_cracklib.so',
      arguments => ['try_first_pass','retry=3', 'minlen=10'],
      target    => '/etc/pam.conf',
    }

### allow multiple entries with same control value

    pam { "Set invalid login 3 times deny in password-auth -fail":
      ensure           => present,
      service          => 'password-auth',
      type             => 'auth',
      control          => '[default=die]',
      control_is_param => true,
      module           => 'pam_faillock.so',
      arguments        => ['authfail','deny=3','unlock_time=604800','fail_interval=900'],
    }
