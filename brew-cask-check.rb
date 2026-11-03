class BrewCaskCheck < Formula
  desc "Run Homebrew's checks upon a cask from a clone of Homebrew/homebrew-cask."
  version '0.0.0'
  license 'MIT'

  homepage 'https://github.com/thoran/brew-cask-check'
  url 'https://github.com/thoran/brew-cask-check.git', tag: 'v0.0.0', revision: '9b04e27d08a538333f59e462851453fdfb6b1a85'

  depends_on 'ruby'

  # switches.rb is the only gem bin/brew-cask-check requires; ostruct is
  # switches.rb's own dependency and is named here so that nothing is fetched
  # during the build.  etc, fileutils and json are required too and are not
  # here, being default gems of the ruby this depends upon.

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.14.3.gem'
    sha256 'ed54fe8d0fd709314623b7f856cd2bca55fbe43c9d0100d4747949afea862d01'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    # Installed with --local and --ignore-dependencies, the resources being the
    # whole of what is needed.  gem install resolves a file's dependencies from
    # what is already installed and from the remote, not from the other files
    # it was given, so without these each dependency named later in the list
    # than a gem needing it would be fetched, at whichever version is newest.

    system 'gem', 'install', '--local', '--ignore-dependencies', '--no-document',
      '--install-dir', libexec/'vendor', *resources.map{|r| r.cached_download.to_s}

    libexec.install 'bin'

    # GEM_HOME and GEM_PATH reach the two vendored gems.  PATH names the ruby
    # this depends on, the script's /usr/bin/env ruby otherwise finding whichever
    # comes first on the user's PATH.

    (bin/'brew-cask-check').write_env_script(
      libexec/'bin/brew-cask-check',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end

  test do
    assert_match 'Usage: brew cask-check', shell_output("#{bin}/brew-cask-check -h")
  end
end
