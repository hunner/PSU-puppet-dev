node default {
  file { '/tmp/foo':
    content => $memoryfree,
  }

  notify { "testing": }

  exec { "/bin/rm /tmp/foo":
    onlyif => "/bin/ls /tmp/foo",
  }

  rcsrepo { "look ma, no provider":
    source   => 'git://github.com/jordansissel/puppet-examples.git',
    path     => '/tmp/gitrepo',
    revision => '984bc68c3f80b7378dcd4e558bf1455f290fe56a',
  }
}
