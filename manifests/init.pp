class tsmclient (
    $hostname   = $tsmclient::params::hostname,
    $nodename   = $tsmclient::params::nodename,
    $clientport = $tsmclient::params::clientport,
    $serverport = $tsmclient::params::serverport,
) inherits tsmclient::params {
    case $::operatingsystem {
        /CentOS|Redhat/ : { include tsmclient::centos }
        /Ubuntu/ : { include tsmclient::ubuntu }
        default : {}
    }
    include tsmclient::common
}
