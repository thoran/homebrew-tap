class GitAutobisect < Formula

  desc "Automate git bisect."
  homepage 'https://github.com/thoran/git-autobisect'
  version '0.4.1'

  url 'https://github.com/thoran/git-autobisect.git'

  depends_on 'ruby'

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.13.0.gem'
    sha256 'a09c89ade14fba2a485b03c725a28636f6350b8d68032dca4abd447d33d6e210'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s
    resources.each(&:fetch)

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}
    libexec.install 'bin'

    # The gems are built by the ruby this depends on, and the script's
    # /usr/bin/env ruby would otherwise find whichever ruby comes first on the
    # user's PATH.  A gem with a compiled extension is built for one and will
    # not load in the other, so the wrapper names the ruby the gems were built
    # against.  switches.rb and ostruct are pure Ruby and would load either way;
    # this is here so that they still do the day one of them is not.

    (bin/'git-autobisect').write_env_script(
      libexec/'bin/git-autobisect',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end

end
