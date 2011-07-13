# GConf2.i386                              2.14.0-9.el5                  installed
# MAKEDEV.i386                             3.23-1.2                      installed
# NetworkManager.i386                      1:0.7.0-10.el5_5.2            installed

IO.popen('yum list installed').readlines.each do |line|
  line =~ /^(\w+)\.i386\s+([\d:\.\-\w]+)/
  package = $1
  version = $2
  next if ! package
  Facter.add("yum_#{package}_version") do
    confine :operatingsystem => ['centos','fedora','redhat']
    setcode do
      version
    end
  end
end
