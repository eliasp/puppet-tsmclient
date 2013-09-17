class tsmclient {
    case $::operatingsystem {
        /CentOS|Redhat/ : { include tsmclient::centos }
        /Ubuntu/ : { include tsmclient::ubuntu }
        default : {}
    }
    include tsmclient::common
}
