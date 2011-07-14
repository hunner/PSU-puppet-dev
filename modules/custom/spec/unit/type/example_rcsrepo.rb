Puppet::Type.newtype(:rcsrepo) do
  newparam(:source) do
    desc "The source URI for the repo"
    validate do |value|
      raise ArgumentError, "Source is not a http(s) or git URL: #{value}" unless value =~ /^(https?|git):\/\//
    end
    munge do |value|
      resource[:provider] = :git if value =~ /^git:\/\//
      value
    end
  end
end
