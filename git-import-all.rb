class GitImportAll < Formula
  desc "Turn a directory of numbered revisions into a git repository, one commit per revision."
  homepage 'https://github.com/thoran/git-import-all'
  version '0.14.0'

  url 'https://github.com/thoran/git-import-all.git'

  depends_on 'ruby'

  resource 'impuri' do
    url 'https://rubygems.org/downloads/impuri-0.12.5.gem'
    sha256 '28e09287192fda3f3e91f827191a6a8571db502f06b444470a2aca5e4133528f'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s
    resources.each(&:fetch)

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}
    libexec.install 'bin', 'lib'

    # RUBYLIB is what makes the vendored lib reachable: bin/git-import-all
    # requires 'Dir/self.existQ' and 'Kernel/run' without putting lib on the
    # load path itself, so without this they resolve only where RUBYLIB already
    # happens to supply them.  PATH names the ruby the gems were built against.

    (bin/'git-import-all').write_env_script(
      libexec/'bin/git-import-all',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
      RUBYLIB: libexec/'lib',
    )
  end
end
