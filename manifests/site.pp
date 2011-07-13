node default {
  file { '/tmp/foo':
    content => $memoryfree,
  }

  notify { "testing": }

  exec { "/bin/rm /tmp/foo":
    onlyif => "/bin/ls /tmp/foo",
  }
}
