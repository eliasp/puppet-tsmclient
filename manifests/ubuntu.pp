class tsmclient::ubuntu {

    $tsmclient_version = '6.4.1.0'

    # create a directory to which the RPM packages for tsmclient will be temporarily extracted to
    file { "/tmp/tsmclient-${tsmclient_version}":
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0700',
    }

    # get the tarball containing all required RPM packages from IBM and extract it
    include archive
    archive { 'tsmclient-tarball':
        ensure        => present,
        url           => 'ftp://ftp.software.ibm.com/storage/tivoli-storage-management/maintenance/client/v6r4/Linux/LinuxX86/BA/v641/6.4.1.0-TIV-TSMBAC-LinuxX86.tar',
        target        => "/tmp/tsmclient-${tsmclient_version}",
        digest_string => '18e38c875011ab9b454b943c7f45a44d',
        extension     => 'tar',
    }


}
