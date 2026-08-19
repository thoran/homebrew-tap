class Ci < Formula

  desc "Open ci from the cli."
  homepage 'https://github.com/thoran/ci'
  version '0.5.1'

  url 'https://github.com/thoran/ci.git'

  depends_on 'ruby'

  resource 'git.rb' do
    url 'https://rubygems.org/downloads/git.rb-0.14.1.gem'
    sha256 '6742e7a5530be754a44b5831aa282b72a64973a7ae3f160777e09e306ea383ff'
  end

  resource 'impuri' do
    url 'https://rubygems.org/downloads/impuri-0.12.0.gem'
    sha256 'c4212aeb0fec02d26c010a02f985bdd6a179d4c80c4c81e9f85ae7d728fa538b'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s
    resources.each do |r|
      r.fetch
      system 'gem', 'install', r.cached_download, '--no-document', '--install-dir', libexec/'vendor'
    end
    libexec.install 'bin'

    # The gems are built by the ruby this depends on, and the script's
    # /usr/bin/env ruby would otherwise find whichever ruby comes first on the
    # user's PATH.  A gem with a compiled extension is built for one and will
    # not load in the other, so the wrapper names the ruby the gems were built
    # against.  git.rb and impuri are pure Ruby and would load either way; this
    # is here so that they still do the day one of them is not.

    (bin/'ci').write_env_script(
      libexec/'bin/ci',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end

end
