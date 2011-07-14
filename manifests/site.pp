node default {
  file { '/tmp/foo':
    content => $memoryfree,
  }

  notify { "testing": }

  exec { "/bin/rm /tmp/foo":
    onlyif => "/bin/ls /tmp/foo",
  }

  rcsrepo { "look ma, no provider":
    path   => "/tmp/gitrepo",
    source => 'https://github.com/jordansissel/puppet-examples.git',
  }
}
