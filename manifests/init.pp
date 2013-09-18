class tsmclient (
    $servername    = params_lookup('servername'),
    $serverport    = params_lookup('serverport'),
    $serveraddress = params_lookup('serveraddress'),
    $clientport    = params_lookup('clientport'),
    $nodename      = params_lookup('nodename'),
    $excludes      = params_lookup('excludes'),
    $includes      = params_lookup('includes')
) inherits tsmclient::params {
    case $::operatingsystem {
        /CentOS|Redhat/ : { include tsmclient::centos }
        /Ubuntu/ : { include tsmclient::ubuntu }
        default : { fail("This module doesn't support ${::operatingsystem} yet.") }
    }
    include tsmclient::common
}
