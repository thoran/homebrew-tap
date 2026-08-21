class GitBoot < Formula
  desc "Create local and remote git repos with a single command."
  homepage 'https://github.com/thoran/git-boot'
  version '0.16.3'

  url 'https://github.com/thoran/git-boot.git'

  depends_on 'ruby'

  # The seven bin/git-boot requires, and the twenty-six they bring with them,
  # most of those by way of sym's dependency upon activesupport.  Every one is
  # named so that nothing is fetched during the build, and because bin/git-boot
  # reaches all seven through require_gem, which installs on a LoadError rather
  # than raising: anything absent here would be installed at runtime into
  # GEM_HOME, which the wrapper points at the keg.

  resource 'activesupport' do
    url 'https://rubygems.org/downloads/activesupport-8.1.3.1.gem'
    sha256 '85458765f25ea48b9019c46b6bb3fa5683197bf4280d9f06710a6e8d7a831376'
  end

  resource 'addressable' do
    url 'https://rubygems.org/downloads/addressable-2.9.0.gem'
    sha256 '7fdf6ac3660f7f4e867a0838be3f6cf722ace541dd97767fa42bc6cfa980c7af'
  end

  resource 'base64' do
    url 'https://rubygems.org/downloads/base64-0.3.0.gem'
    sha256 '27337aeabad6ffae05c265c450490628ef3ebd4b67be58257393227588f5a97b'
  end

  resource 'bigdecimal' do
    url 'https://rubygems.org/downloads/bigdecimal-4.1.2.gem'
    sha256 '53d217666027eab4280346fba98e7d5b66baaae1b9c3c1c0ffe89d48188a3fbd'
  end

  resource 'colored2' do
    url 'https://rubygems.org/downloads/colored2-3.1.2.gem'
    sha256 'b13c2bd7eeae2cf7356a62501d398e72fde78780bd26aec6a979578293c28b4a'
  end

  resource 'concurrent-ruby' do
    url 'https://rubygems.org/downloads/concurrent-ruby-1.3.8.gem'
    sha256 'b2f1be836e968ccc78ccfce277ea79c72a88633f22306782c16ff23fb415d1e1'
  end

  resource 'connection_pool' do
    url 'https://rubygems.org/downloads/connection_pool-3.0.2.gem'
    sha256 '33fff5ba71a12d2aa26cb72b1db8bba2a1a01823559fb01d29eb74c286e62e0a'
  end

  resource 'dalli' do
    url 'https://rubygems.org/downloads/dalli-5.0.6.gem'
    sha256 '01887253a3e788124b9e04e90b63dc54ea9ef69f981d6f5fa2a4debc9e62a456'
  end

  resource 'drb' do
    url 'https://rubygems.org/downloads/drb-2.2.3.gem'
    sha256 '0b00d6fdb50995fe4a45dea13663493c841112e4068656854646f418fda13373'
  end

  resource 'faraday' do
    url 'https://rubygems.org/downloads/faraday-2.14.3.gem'
    sha256 '1882247e6766615c8220b4392bf1d27f6ebb63d8e28267587cef1fb0bf37f278'
  end

  resource 'faraday-net_http' do
    url 'https://rubygems.org/downloads/faraday-net_http-3.4.4.gem'
    sha256 '0e78af151747ed1b00f33e25973b4bc220d7f16c00c39676817c8b12331eb588'
  end

  resource 'faraday-retry' do
    url 'https://rubygems.org/downloads/faraday-retry-2.4.0.gem'
    sha256 '7b79c48fb7e56526faf247b12d94a680071ff40c9fda7cf1ec1549439ad11ebe'
  end

  resource 'highline' do
    url 'https://rubygems.org/downloads/highline-3.1.2.gem'
    sha256 '67cbd34d19f6ef11a7ee1d82ffab5d36dfd5b3be861f450fc1716c7125f4bb4a'
  end

  resource 'i18n' do
    url 'https://rubygems.org/downloads/i18n-1.15.2.gem'
    sha256 '00f9eb62412fe593b2a65a97daa75300d37abb8f7202ec748e94b6d46a9dd1b5'
  end

  resource 'impuri' do
    url 'https://rubygems.org/downloads/impuri-0.12.5.gem'
    sha256 '28e09287192fda3f3e91f827191a6a8571db502f06b444470a2aca5e4133528f'
  end

  resource 'io-console' do
    url 'https://rubygems.org/downloads/io-console-0.9.2.gem'
    sha256 'efa74f891dd03c0939a931dfc6e74c2813d904763d456ea9762b0525e748db08'
  end

  resource 'json' do
    url 'https://rubygems.org/downloads/json-2.21.2.gem'
    sha256 '1f1d3b7cf2b3ba1a69beca0bb6db13d5438b80bff3cd54cdaaa620b9b07c1c6a'
  end

  resource 'logger' do
    url 'https://rubygems.org/downloads/logger-1.7.0.gem'
    sha256 '196edec7cc44b66cfb40f9755ce11b392f21f7967696af15d274dde7edff0203'
  end

  resource 'minitest' do
    url 'https://rubygems.org/downloads/minitest-6.0.6.gem'
    sha256 '153ea36d1d987a62942382b61075745042a2b3123b1cd48f4c3675af9cc7d6f1'
  end

  resource 'net-http' do
    url 'https://rubygems.org/downloads/net-http-0.9.1.gem'
    sha256 '25ba0b67c63e89df626ed8fac771d0ad24ad151a858af2cc8e6a716ca4336996'
  end

  resource 'net-ssh' do
    url 'https://rubygems.org/downloads/net-ssh-7.3.3.gem'
    sha256 '831def58b2c51dcef66ec00d29397d4f210de89c19fe78f95873ca30f386e86a'
  end

  resource 'octokit' do
    url 'https://rubygems.org/downloads/octokit-10.0.0.gem'
    sha256 '82e99a539b7637b7e905e6d277bb0c1a4bed56735935cc33db6da7eae49a24e8'
  end

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'prism' do
    url 'https://rubygems.org/downloads/prism-1.9.0.gem'
    sha256 '7b530c6a9f92c24300014919c9dcbc055bf4cdf51ec30aed099b06cd6674ef85'
  end

  resource 'public_suffix' do
    url 'https://rubygems.org/downloads/public_suffix-7.0.5.gem'
    sha256 '1a8bb08f1bbea19228d3bed6e5ed908d1cb4f7c2726d18bd9cadf60bc676f623'
  end

  resource 'reline' do
    url 'https://rubygems.org/downloads/reline-0.7.0.gem'
    sha256 '5b012d8e55dbf9d450f12bde2cf7d15ff546ae80b3f8f3b30e570d431815583d'
  end

  resource 'sawyer' do
    url 'https://rubygems.org/downloads/sawyer-0.9.3.gem'
    sha256 '0d0f19298408047037638639fe62f4794483fb04320269169bd41af2bdcf5e41'
  end

  resource 'securerandom' do
    url 'https://rubygems.org/downloads/securerandom-0.4.1.gem'
    sha256 'cc5193d414a4341b6e225f0cb4446aceca8e50d5e1888743fac16987638ea0b1'
  end

  resource 'slop' do
    url 'https://rubygems.org/downloads/slop-4.10.1.gem'
    sha256 '844322b5ffcf17ed4815fdb173b04a20dd82b4fd93e3744c88c8fafea696d9c7'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.13.0.gem'
    sha256 'a09c89ade14fba2a485b03c725a28636f6350b8d68032dca4abd447d33d6e210'
  end

  resource 'sym' do
    url 'https://rubygems.org/downloads/sym-3.0.2.gem'
    sha256 '1c4bfbab59297f75dcb85df1b9d389b41e73bf69903831718da0504313ff5231'
  end

  resource 'tzinfo' do
    url 'https://rubygems.org/downloads/tzinfo-2.0.6.gem'
    sha256 '8daf828cc77bcf7d63b0e3bdb6caa47e2272dcfaf4fbfe46f8c3a9df087a829b'
  end

  resource 'uri' do
    url 'https://rubygems.org/downloads/uri-1.1.1.gem'
    sha256 '379fa58d27ffb1387eaada68c749d1426738bd0f654d812fcc07e7568f5c57c6'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    # Installed in one call rather than one apiece, so that each gem's
    # dependencies are satisfied from the others here.

    resources.each(&:fetch)

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}

    libexec.install 'bin', 'lib', 'templates'

    # RUBYLIB reaches the vendored lib, which the forty-four files of it were
    # previously installed into the shared prefix to satisfy, where they
    # collided with every other formula's copy of Version.rb and Ordinal.
    # PATH names the ruby the gems were built against: bigdecimal, io-console,
    # json and prism each carry a compiled extension, which is built for one
    # ruby and will not load in another.

    (bin/'git-boot').write_env_script(
      libexec/'bin/git-boot',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
      RUBYLIB: libexec/'lib',
    )
  end
end
