class tsm::client::common {

    service { 'dsmcad':
        ensure      => running,
        subscribe   => [
            File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'],
            File['/opt/tivoli/tsm/client/ba/bin/dsm.opt'],
        ],
        enable      => true,
        pattern     => 'dsmcad',
    }

    file { '/var/log/tsm':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
    }

    file { '/opt/tivoli/tsm/client/ba/bin/dsm.opt':
        owner   => 'root',
        group   => 'bin',
        mode    => '0644',
        require => Package['TIVsm-BA'],
        content => template('tsmclient/dsm.opt.erb'),
    }

    file { '/opt/tivoli/tsm/client/ba/bin/dsm.sys':
        owner   => root,
        group   => bin,
        mode    => '0644',
        require => File['/opt/tivoli/tsm/client/ba/bin/dsm.opt'],
        content => template('tsmclient/dsm.sys.erb'),
    }

    file { '/etc/profile.d/dsmcad-paths.sh':
        owner   => root,
        group   => root,
        mode    => '0644',
        require => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'],
        source  => 'puppet:///modules/tsmclient/dsmcad-paths.sh',
    }

    # Check TSM password is valid and update if not
    exec { 'store-password':
        cwd     => '/opt/tivoli/tsm/client/ba/bin',
        path    => '/opt/tivoli/tsm/client/ba/bin',
        require => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'],
        command => "./dsmc set password ${::tsmpassword} ${::tsmpassword}",
        onlyif  => './dsmc query session </dev/null | /bin/grep ^ANS1025E',
    }
}
