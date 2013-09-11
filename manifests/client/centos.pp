class tsm::client::centos {

    package { 'gskcrypt32':
        ensure      => latest,
        provider    => rpm,
        source      => 'http://puppet.example.co.uk/files/tsmclient/gskcrypt32-8.0.13.3.linux.x86.rpm',
    }
    package { 'gskssl32':
        ensure      => latest,
        provider    => rpm,
        source      => 'http://puppet.example.co.uk/files/tsmclient/gskssl32-8.0.13.3.linux.x86.rpm',
        require     => Package['gskcrypt32'],
    }
    package { 'libstdc++':
        ensure  => installed,
    }
    package { 'compat-libstdc++-33':
        ensure  => installed,
    }
    package { 'TIVsm-API':
        ensure => latest,
        provider => rpm,
        source => 'http://puppet.example.co.uk/files/tsmclient/TIVsm-API.i386.rpm',
        require => [ Package['gskcrypt32'], Package['libstdc++'], Package['compat-libstdc++-33'] ],
    }
    package { 'TIVsm-BA':
        ensure => latest,
        provider => rpm,
        source => 'http://puppet.example.co.uk/files/tsmclient/TIVsm-BA.i386.rpm',
        require => Package['TIVsm-API'],
    }
    # 64 bit architecture requires that you install all of the 32 bit components first..
    case $::architecture {
        x86_64 : {
            package { 'gskcrypt64':
                ensure      => latest,
                provider    => rpm,
                source      => 'http://puppet.example.co.uk/files/tsmclient/gskcrypt64-8.0.13.3.linux.x86_64.rpm',
            }
            package { 'gskssl64':
                ensure      => latest,
                provider    => rpm,
                source      => 'http://puppet.example.co.uk/files/tsmclient/gskssl64-8.0.13.3.linux.x86_64.rpm',
                require     => Package['gskcrypt64'],
            }
            package { 'TIVsm-API64':
                ensure => latest,
                provider => rpm,
                source => 'http://puppet.example.co.uk/files/tsmclient/TIVsm-API64.i386.rpm',
                require => [ Package['gskcrypt64'], Package['TIVsm-API'] ],
            }
        },
        default : {}
    } # case architecture

    file { 'tsm_client_init':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '755',
        path    => '/etc/init.d/dsmcad',
        source  => 'puppet:///modules/tsmclient/dsmcad-centos',
        require => $::architecture ? {
            i386 => [ Package['TIVsm-API'],
                Package['TIVsm-BA'],
                File['/var/log/tsm'],
                File['/opt/tivoli/tsm/client/ba/bin/dsm.opt'],
                File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'] ],
            x86_64 => [ Package['TIVsm-API'],
                Package['TIVsm-BA'],
                Package['TIVsm-API64'],
                File['/var/log/tsm'],
                File['/opt/tivoli/tsm/client/ba/bin/dsm.opt'],
                File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'] ],
            },
    } # file
} # class
