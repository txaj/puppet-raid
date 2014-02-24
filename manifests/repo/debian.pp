class raid::repo::debian {
  apt::source { 'raid':
    location   => 'http://hwraid.le-vert.net/debian',
    release    => $::lsbdistcodename,
    repos      => 'main',
    key        => '23B3D3B4',
    key_server => 'keyserver.ubuntu.com',
  }
}
