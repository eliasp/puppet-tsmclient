class tsmclient (
    $hostname   = params_lookup('hostname'),
    $nodename   = params_lookup('nodename'),
    $clientport = params_lookup('clientport'),
    $serverport = params_lookup('serverport'),
) inherits tsmclient::params {
    case $::operatingsystem {
        /CentOS|Redhat/ : { include tsmclient::centos }
        /Ubuntu/ : { include tsmclient::ubuntu }
        default : {}
    }
    include tsmclient::common
}
