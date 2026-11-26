class Yacy < Formula
  desc "Install, start, stop and uninstall YaCy, the peer-to-peer search engine, on macOS or Linux, and open its page."
  version '0.10.0'
  license 'MIT'

  homepage 'https://github.com/thoran/yacy'
  url 'https://github.com/thoran/yacy.git', tag: 'v0.10.0', revision: 'bd62115a62a0f778a31f952a1221eed2f14e4c43'

  depends_on 'ruby'
  depends_on 'xz' => :build

  # nokogiri and switches.rb are the gems yacy requires everywhere.
  # mini_portile2 and racc come in with nokogiri, mini_portile2 to build its
  # extension, and ostruct with switches.rb, and are named here so that nothing
  # is fetched during the build.

  resource 'mini_portile2' do
    url 'https://rubygems.org/downloads/mini_portile2-2.8.9.gem'
    sha256 '0cd7c7f824e010c072e33f68bc02d85a00aeb6fce05bb4819c03dfd3c140c289'
  end

  resource 'nokogiri' do
    url 'https://rubygems.org/downloads/nokogiri-1.19.7.gem'
    sha256 'abe94507c54cb18f872777b16bdca4aad32b1abdc4c52fe843f1c80fbdf992b8'
  end

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'racc' do
    url 'https://rubygems.org/downloads/racc-1.8.1.gem'
    sha256 '4a7f6929691dbec8b5209a0b373bc2614882b55fc5d2e447a21aaa691303d62f'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.14.4.gem'
    sha256 '8f717055484e357f2d54a151f913fccad2e224d0c70e1a465a0911049327a452'
  end

  # macos.rb mounts YaCy's disk image, which there is only on macOS.  The rest
  # come in with it: CFPropertyList and plist with macos.rb, and base64, nkf and
  # rexml with CFPropertyList, each a bundled gem rather than a default one, and
  # so not to be found once GEM_PATH is the vendor directory alone.

  on_macos do
    resource 'base64' do
      url 'https://rubygems.org/downloads/base64-0.3.0.gem'
      sha256 '27337aeabad6ffae05c265c450490628ef3ebd4b67be58257393227588f5a97b'
    end

    resource 'CFPropertyList' do
      url 'https://rubygems.org/downloads/CFPropertyList-4.0.0.gem'
      sha256 '385e7bbd7c27e176b23415275ca936ca0ece1727e5b890b08e36632076b00aff'
    end

    resource 'macos.rb' do
      url 'https://rubygems.org/downloads/macos.rb-0.55.0.gem'
      sha256 '104686d7cc1948b90a8b9b5725d3dd519b53d224fe3bba14cee6b3c3658d667e'
    end

    resource 'nkf' do
      url 'https://rubygems.org/downloads/nkf-0.3.0.gem'
      sha256 '357a8dbeba38b727b75930f665146546076a394a1c243faf634ff176e3588895'
    end

    resource 'plist' do
      url 'https://rubygems.org/downloads/plist-3.7.2.gem'
      sha256 'd37a4527cc1116064393df4b40e1dbbc94c65fa9ca2eec52edf9a13616718a42'
    end

    resource 'rexml' do
      url 'https://rubygems.org/downloads/rexml-3.4.4.gem'
      sha256 '19e0a2c3425dfbf2d4fc1189747bdb2f849b6c5e74180401b15734bc97b5d142'
    end
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
    libexec.install 'bin', 'lib'

    # The wrapper execs the script, which is made executable here whatever mode
    # it was committed with.

    chmod 0755, libexec/'bin/yacy'

    # The gems are built by the ruby this depends on, and the script's
    # /usr/bin/env ruby would otherwise find whichever ruby comes first on the
    # user's PATH.  nokogiri's extension is built for one and will not load in
    # the other, so the wrapper names the ruby the gems were built against.

    (bin/'yacy').write_env_script(
      libexec/'bin/yacy',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
      RUBYLIB: libexec/'lib',
    )
  end

  def caveats
    <<~EOS
      brew uninstall yacy removes the command, and leaves YaCy. To remove YaCy too, first run:
        yacy uninstall
      YaCy's DATA, holding its index, its settings and the peer's identity, is kept unless --data is given.
    EOS
  end

  test do
    assert_predicate bin/'yacy', :executable?
    assert_match 'Usage: yacy', shell_output("#{bin}/yacy --help")
  end
end
