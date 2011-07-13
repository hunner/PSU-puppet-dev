node default {
  import 'test.pp'
# $location = 'dev'

# notify { "Classes to include":
#   message => hiera_array("classes"),
# }

# $files = hiera_hash("files")
# create_resources("file", $files) 

# file { "/tmp/zot":
#   owner => 'root',
#   group => 'root',
# }

# notify { "foo":
#   message => "bar",
# }
}
