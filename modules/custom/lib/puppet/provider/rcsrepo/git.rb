Puppet::Type.type(:rcsrepo).provide(:git) do
  desc "This is the git provider for the rcsrepo type"

  commands :git => 'git'
end
