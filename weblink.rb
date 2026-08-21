class Weblink < Formula
  desc "A CLI program for generating and converting weblink or web shortcut files."
  version '0.11.2'

  homepage 'https://github.com/thoran/weblink'
  url 'https://github.com/thoran/weblink.git'

  depends_on 'ruby'

  # bin/weblink defines its own require_gem, which upon LoadError shells out to
  # `gem install switches.rb` and requires again.  install() put the script into
  # the keg by itself, so that rescue was the whole of the dependency handling:
  # a first run either installed switches.rb into whichever gem home the
  # invoking shell had, or failed outright where there was none to write to.
  # ostruct is switches.rb's own dependency, and is named here so that nothing
  # is fetched during the build.  rexml is required by the script directly: it
  # is a bundled gem rather than a default one, so it lives in the gems
  # directory and the GEM_PATH the wrapper sets shuts it out along with
  # everything else there.  ostruct is the same, notwithstanding that it also
  # happens to be installed into the shared gem directory on this machine.

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'rexml' do
    url 'https://rubygems.org/downloads/rexml-3.4.4.gem'
    sha256 '19e0a2c3425dfbf2d4fc1189747bdb2f849b6c5e74180401b15734bc97b5d142'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.13.0.gem'
    sha256 'a09c89ade14fba2a485b03c725a28636f6350b8d68032dca4abd447d33d6e210'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    # Installed in one call rather than one apiece, so that switches.rb's
    # dependency upon ostruct is satisfied from here and nothing is fetched.

    resources.each(&:fetch)

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}

    libexec.install 'bin'

    # GEM_HOME and GEM_PATH reach the three vendored gems, so that require_gem
    # finds switches.rb and never reaches its rescue.  PATH names the ruby this
    # depends on, the script's /usr/bin/env ruby otherwise finding whichever
    # comes first on the user's PATH.  Both gems are pure Ruby and would load
    # either way; this is here so that they still do the day one of them is not.

    (bin/'weblink').write_env_script(
      libexec/'bin/weblink',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end
end
