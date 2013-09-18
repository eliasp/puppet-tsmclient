class tsmclient::params {
    $servername    = $::fqdn
    $serverport    = '1500'
    $serveraddress = ''
    $clientport    = ''
    $nodename      = $::fqdn
    $hostname      = $::fqdn
    $tsmport       = '1500'
    $tsmserver     = ''
    $hostname      = ''
    $exclude       = {
        'fs'    => ['/.../'],
        'dir'   => [
            '/.../',
            '/opt/tivoli/tsm/.../',
        ],
        'items' => ['/.../'],
    }
    $include       = {
        'items' => [],
    }
}
