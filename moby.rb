class Moby < Formula
  desc "Sometimes when they go fishing, they get a whale and it sinks their boat."
  homepage 'https://github.com/thoran/moby'
  version '2.1.5'
  license 'MIT'

  url 'https://github.com/thoran/moby.git'

  depends_on 'ruby'

  # The three gems moby requires, switches.rb, mechanize and selenium-webdriver,
  # and the twenty-one they bring with them, each named so that nothing is
  # fetched during the build.  mechanize is 2.14.1 rather than 2.9.1, which
  # requires mutex_m without declaring it and so does not load in Ruby 4.0.
  # nokogiri is precompiled per platform, so the gem is the one for the
  # machine's architecture.

  resource 'addressable' do
    url 'https://rubygems.org/downloads/addressable-2.9.0.gem'
    sha256 '7fdf6ac3660f7f4e867a0838be3f6cf722ace541dd97767fa42bc6cfa980c7af'
  end

  resource 'base64' do
    url 'https://rubygems.org/downloads/base64-0.3.0.gem'
    sha256 '27337aeabad6ffae05c265c450490628ef3ebd4b67be58257393227588f5a97b'
  end

  resource 'connection_pool' do
    url 'https://rubygems.org/downloads/connection_pool-3.0.2.gem'
    sha256 '33fff5ba71a12d2aa26cb72b1db8bba2a1a01823559fb01d29eb74c286e62e0a'
  end

  resource 'domain_name' do
    url 'https://rubygems.org/downloads/domain_name-0.7.20261007.gem'
    sha256 '0976c6ab837dbde991b433d03acc38fdb91fa8839df31a1ed75ce0318dc0441c'
  end

  resource 'http-cookie' do
    url 'https://rubygems.org/downloads/http-cookie-1.1.6.gem'
    sha256 'ba4b82be64de61dc281243dac70e3c382c45142f20268ed9276a3670c93feaa9'
  end

  resource 'logger' do
    url 'https://rubygems.org/downloads/logger-1.7.0.gem'
    sha256 '196edec7cc44b66cfb40f9755ce11b392f21f7967696af15d274dde7edff0203'
  end

  resource 'mechanize' do
    url 'https://rubygems.org/downloads/mechanize-2.14.1.gem'
    sha256 'b66205133a01d3dc3bc0cbc5e99888e5476818398d8d315193429f21488abafd'
  end

  resource 'mime-types' do
    url 'https://rubygems.org/downloads/mime-types-3.7.0.gem'
    sha256 'dcebf61c246f08e15a4de34e386ebe8233791e868564a470c3fe77c00eed5e56'
  end

  resource 'mime-types-data' do
    url 'https://rubygems.org/downloads/mime-types-data-3.2026.1013.gem'
    sha256 '370f152f2a47e54e58829766492ea2cbe130a45358374b8788a6a8ad4e961c96'
  end

  resource 'net-http-digest_auth' do
    url 'https://rubygems.org/downloads/net-http-digest_auth-1.4.1.gem'
    sha256 '4b8ad50ed8d180a58db5d6c49449b987dd0466fe01e24037945bc007562a08db'
  end

  resource 'net-http-persistent' do
    url 'https://rubygems.org/downloads/net-http-persistent-4.0.8.gem'
    sha256 'ef3de8319d691537b329053fae3a33195f8b070bbbfae8bf1a58c796081960e6'
  end

  resource 'nkf' do
    url 'https://rubygems.org/downloads/nkf-0.3.0.gem'
    sha256 '357a8dbeba38b727b75930f665146546076a394a1c243faf634ff176e3588895'
  end

  resource 'nokogiri' do
    on_arm do
      url 'https://rubygems.org/downloads/nokogiri-1.19.4-arm64-darwin.gem'
      sha256 'a46db9853286e6597b36ebc6953817d15acf3a299583eb3f89fdc6f91dd63527'
    end

    on_intel do
      url 'https://rubygems.org/downloads/nokogiri-1.19.4-x86_64-darwin.gem'
      sha256 '7fd17057d3e1f00e9954a74b3cd76595d3d4a5ef233b7ed9599047c204f70551'
    end
  end

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'public_suffix' do
    url 'https://rubygems.org/downloads/public_suffix-7.0.5.gem'
    sha256 '1a8bb08f1bbea19228d3bed6e5ed908d1cb4f7c2726d18bd9cadf60bc676f623'
  end

  resource 'racc' do
    url 'https://rubygems.org/downloads/racc-1.8.1.gem'
    sha256 '4a7f6929691dbec8b5209a0b373bc2614882b55fc5d2e447a21aaa691303d62f'
  end

  resource 'rexml' do
    url 'https://rubygems.org/downloads/rexml-3.4.4.gem'
    sha256 '19e0a2c3425dfbf2d4fc1189747bdb2f849b6c5e74180401b15734bc97b5d142'
  end

  resource 'rubyntlm' do
    url 'https://rubygems.org/downloads/rubyntlm-0.6.8.gem'
    sha256 '054aa45ffcae40db4020d3e41da41f40427aa8733181a2b87751f04ba53ca0d5'
  end

  resource 'rubyzip' do
    url 'https://rubygems.org/downloads/rubyzip-3.7.0.gem'
    sha256 '65c19294da75297a939006f3516deacc33185fbd721ff1954f7a231db6d3e121'
  end

  resource 'selenium-webdriver' do
    url 'https://rubygems.org/downloads/selenium-webdriver-4.47.0.gem'
    sha256 '67f915b8223d2133bbaa13e92fd98854175394f086e2036a9eff4f5561fd69e4'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.14.0.gem'
    sha256 'b6c0fa8c22277fd40c3070864040da75bc48086012d8db8b3fdc88a50c7f312a'
  end

  resource 'webrick' do
    url 'https://rubygems.org/downloads/webrick-1.9.2.gem'
    sha256 'beb4a15fc474defed24a3bda4ffd88a490d517c9e4e6118c3edce59e45864131'
  end

  resource 'webrobots' do
    url 'https://rubygems.org/downloads/webrobots-0.1.2.gem'
    sha256 'ebbcaa2cb4930fa1b83206f432c5cb64746507b2dcf50ea1301569a4d662cda6'
  end

  resource 'websocket' do
    url 'https://rubygems.org/downloads/websocket-1.2.11.gem'
    sha256 'b7e7a74e2410b5e85c25858b26b3322f29161e300935f70a0e0d3c35e0462737'
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

    # The whole tree into libexec, bin and lib staying siblings there so that
    # bin/moby's own '..', 'lib' resolves inside moby rather than in the shared
    # prefix.

    libexec.install 'bin', 'lib'

    # GEM_HOME and GEM_PATH reach the vendored gems, and RUBYLIB the vendored lib.
    # PATH names the ruby the gems were built against: nkf, nokogiri and racc
    # each carry a compiled extension, which is built for one ruby and will not
    # load in another.

    (bin/'moby').write_env_script(
      libexec/'bin/moby',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
      RUBYLIB: libexec/'lib',
    )
  end
end
