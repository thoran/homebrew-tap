class GemAnnounce < Formula
  desc "Announce an owner's gems to a mailing list."
  homepage 'https://github.com/thoran/gem-announce'
  version '0.7.0'
  license 'MIT'

  url 'https://github.com/thoran/gem-announce.git', tag: 'v0.7.0', revision: '78a879451ec81f309d6d9d32750022d4ab19feb1'

  depends_on 'ruby'

  # bin/gem-announce requires gems, net-smtp and switches.rb, and switches.rb
  # requires ostruct.  net-smtp and ostruct are bundled gems rather than default
  # ones, which is a thing to be shipped rather than assumed.  net-smtp's own
  # net-protocol, and its timeout, are default gems, and come with the ruby.

  resource 'gems' do
    url 'https://rubygems.org/downloads/gems-3.0.0.gem'
    sha256 'a7c7853385dbf73b2f252c735c38eced146cce7530a39d4255751149f1cde696'
  end

  resource 'net-smtp' do
    url 'https://rubygems.org/downloads/net-smtp-0.5.2.gem'
    sha256 '35103cc04d6b2d94632f9928ede07483c24b70b9c0db1f231fea43909b678f3c'
  end

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

    # GEM_HOME and GEM_PATH reach the four vendored gems, and shut out the gem
    # home the invoking shell has, that one having been built for another ruby.

    (bin/'gem-announce').write_env_script(
      libexec/'bin/gem-announce',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end
end
