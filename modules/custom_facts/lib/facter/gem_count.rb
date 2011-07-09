Facter.add('gem_count') do
  setcode do
    IO.popen('gem list').readlines.size.to_s
  end
end
