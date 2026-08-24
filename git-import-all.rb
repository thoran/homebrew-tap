class GitImportAll < Formula
  desc "Turn a directory of numbered revisions into a git repository, one commit per revision."
  homepage 'https://github.com/thoran/git-import-all'
  version '0.15.0'
  license 'MIT'

  url 'https://github.com/thoran/git-import-all.git'

  depends_on 'ruby'

  def install
    libexec.install 'bin', 'lib'

    # RUBYLIB is what makes the bundled lib reachable: bin/git-import-all requires
    # 'Kernel/run' without putting lib on the load path itself.  PATH names the
    # ruby it is run with.

    (bin/'git-import-all').write_env_script(
      libexec/'bin/git-import-all',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      RUBYLIB: libexec/'lib',
    )
  end
end
