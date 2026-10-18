class GitSyncFork < Formula
  desc "Sync a fork with the repository it was forked from."
  version '0.6.2'
  license 'MIT'

  homepage 'https://github.com/thoran/git-sync-fork'
  url 'https://github.com/thoran/git-sync-fork.git'

  depends_on 'ruby'

  # git.rb is the only gem bin/git-sync-fork requires.

  resource 'git.rb' do
    url 'https://rubygems.org/downloads/git.rb-0.15.1.gem'
    sha256 '3d00113b2e8babe720985248c4cbc9ab9e0c7255801bfdb1d9ff90a9c2032543'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}

    libexec.install 'bin'

    # GEM_HOME and GEM_PATH reach the vendored gem.  PATH names the ruby this
    # depends on, the script's /usr/bin/env ruby otherwise finding whichever
    # comes first on the user's PATH.

    (bin/'git-sync-fork').write_env_script(
      libexec/'bin/git-sync-fork',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end
end
