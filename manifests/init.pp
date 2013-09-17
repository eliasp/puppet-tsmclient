class tsmclient (
    $hostname = $tsmclient::params::hostname,
    $nodename = $tsmclient::params::nodename,
) inherits tsmclient::params {
    case $::operatingsystem {
        /CentOS|Redhat/ : { include tsmclient::centos }
        /Ubuntu/ : { include tsmclient::ubuntu }
        default : {}
    }
    include tsmclient::common
}
