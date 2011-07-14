Puppet::Type.type(:rcsrepo).provide(:git) do
  desc "This is the git provider for the rcsrepo type"

  commands :git => 'git'

  def exists?
    File.directory?(resource[:path] + '/.git')
  end

  def create
    # If the source property is set, `git clone` should be used to pull it down to path
    # Otherwise, an empty repository should be created with `git init`

    if resource[:source]
      FileUtils.rm_rf resource[:path] if File.exists? resource[:path]
      git("clone", resource[:source], resource[:path])
    else
      FileUtils.mkdir_p resource[:path] if ! File.directory? resource[:path]
      git_init resource[:path]
    end
  end

  def destroy
    FileUtils.rm_rf resource[:path] if File.directory?(resource[:path] + '/.git')
  end

  def git_init(path)
    git("--git-dir", path + '/.git', "--work-tree", path, "init")
  end
end
