class tsmclient::params {
    $servername    = $::fqdn
    $serverport    = '1500'
    $serveraddress = ''
    $clientport    = '1500'
    $nodename      = $::fqdn
    $excludes      = {
        fs   => ['/.../'],
        dir  => [
            '/.../',
            '/opt/tivoli/tsm/.../',
        ],
        list => ['/.../'],
    }
    $includes      = {
        list => [],
    }
}
