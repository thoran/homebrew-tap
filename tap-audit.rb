class TapAudit < Formula
  desc "Report what each formula in a Homebrew tap has drifted from."
  version '0.14.2'
  license 'MIT'

  homepage 'https://github.com/thoran/tap-audit'
  url 'https://github.com/thoran/tap-audit.git'

  depends_on 'ruby'

  # switches.rb is the only gem bin/tap-audit requires; ostruct is switches.rb's
  # own dependency and is named here so that nothing is fetched during the build.
  # json is required too and is not here, being a default gem: it ships with the
  # ruby this depends upon rather than living in the gems directory, so the
  # GEM_PATH the wrapper sets does not shut it out.

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.14.0.gem'
    sha256 'b6c0fa8c22277fd40c3070864040da75bc48086012d8db8b3fdc88a50c7f312a'
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
    # comes first on the user's PATH — which matters here beyond the usual, json
    # being a default gem of that ruby rather than something vendored.

    (bin/'tap-audit').write_env_script(
      libexec/'bin/tap-audit',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end
end
