class AbnBulkExtract < Formula
  desc "Fetch, compare and parse the Australian Business Register's weekly ABN bulk extract from data.gov.au."
  version '0.2.0'
  license 'MIT'

  homepage 'https://github.com/thoran/abn-bulk-extract'
  url 'https://github.com/thoran/abn-bulk-extract.git', tag: 'v0.2.0', revision: 'a00b93c658372425de659446c20ac7aa88ac964c'

  depends_on 'ruby'

  # data_gov_au and switches.rb are the gems abn-bulk-extract requires; http.rb,
  # ox, rubyzip and zstd-ruby are data_gov_au's, bigdecimal is ox's, and ostruct
  # is switches.rb's.  logger is required too and is here, being a bundled gem
  # rather than a default one: it lives in the gems directory of the ruby this
  # depends upon, which the GEM_PATH the wrapper sets shuts out, as it does
  # ostruct and bigdecimal.  Every one is named so that nothing is fetched
  # during the build.

  resource 'bigdecimal' do
    url 'https://rubygems.org/downloads/bigdecimal-4.1.3.gem'
    sha256 '61ebe1e5e559bdc3cc6f2c0ee7f427321fc838f59611c294356eb04d6e21cf66'
  end

  resource 'data_gov_au' do
    url 'https://rubygems.org/downloads/data_gov_au-0.4.0.gem'
    sha256 '417bd8422f1612474d2bea339c942e5f541d0f7d1fc34bf826fead6adc67e019'
  end

  resource 'http.rb' do
    url 'https://rubygems.org/downloads/http.rb-1.7.1.gem'
    sha256 'a7a43f10dab5703f1954e051b2f1118a3eb577e9736f1b47c3bd59e3ec475c01'
  end

  resource 'logger' do
    url 'https://rubygems.org/downloads/logger-1.7.0.gem'
    sha256 '196edec7cc44b66cfb40f9755ce11b392f21f7967696af15d274dde7edff0203'
  end

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'ox' do
    url 'https://rubygems.org/downloads/ox-2.14.29.gem'
    sha256 '206736d5a8dade9dca10cf72022bc157ad6ca3eecaba3853918426ed88e12dc2'
  end

  resource 'rubyzip' do
    url 'https://rubygems.org/downloads/rubyzip-3.7.0.gem'
    sha256 '65c19294da75297a939006f3516deacc33185fbd721ff1954f7a231db6d3e121'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.14.4.gem'
    sha256 '8f717055484e357f2d54a151f913fccad2e224d0c70e1a465a0911049327a452'
  end

  resource 'zstd-ruby' do
    url 'https://rubygems.org/downloads/zstd-ruby-2.0.10.gem'
    sha256 'b5f9410ccfad78ae25c3a5d7dfe16234d2bde8841fc79d8166773fd0a4028f9d'
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

    # GEM_HOME and GEM_PATH reach the vendored gems.  PATH names the ruby the
    # gems were built against: bigdecimal, ox and zstd-ruby each carry a
    # compiled extension, which is built for one ruby and will not load in
    # another.

    (bin/'abn-bulk-extract').write_env_script(
      libexec/'bin/abn-bulk-extract',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end

  test do
    assert_match 'Usage: abn-bulk-extract', shell_output("#{bin}/abn-bulk-extract -h")
  end
end
