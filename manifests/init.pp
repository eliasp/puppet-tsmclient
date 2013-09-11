# Class for tsm clients
class tsm::client {
    case $::operatingsystem {
        /CentOS|Redhat/ : { include tsm::client::centos }
        /Ubuntu/ : { include tsm::client::ubuntu }
        default : {}
    }
    include tsm::client::common
}


