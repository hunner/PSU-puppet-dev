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
      git_path "init"
    end
  end

  def destroy
    FileUtils.rm_rf resource[:path] if File.directory?(resource[:path] + '/.git')
  end

  def revision
    #git("--git-dir", path + '/.git', 'rev-parse', 'HEAD')
    git_path("rev-parse", "HEAD").chomp
  end

  def revision=(rev)
    git_path('fetch', 'origin')
    git_path('reset', '--hard', rev)
  end

  def git_path(*args)
    git("--git-dir", resource[:path] + '/.git', "--work-tree", resource[:path], *args)
  end
end
