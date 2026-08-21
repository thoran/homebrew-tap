class GitCheckoutNewIssue < Formula

  desc "Create a new branch at the same time as creating a new issue. Only works with Jira for now."
  homepage 'https://github.com/thoran/git-checkout-new-issue'
  version '0.3.2'

  url 'https://github.com/thoran/git-checkout-new-issue.git'

  depends_on 'ruby'

  # The three the script requires, and the nine activesupport brings with it.
  # Homebrew wants every input declared and checksummed rather than fetched
  # during the build, so the whole closure is named here and installed together.

  resource 'activesupport' do
    url 'https://rubygems.org/downloads/activesupport-7.0.7.2.gem'
    sha256 '62e01393689c8514a65e2cf8be6f4781d1e6c7d9adc25b1056902d8abd659fee'
  end

  resource 'bigdecimal' do
    url 'https://rubygems.org/downloads/bigdecimal-4.1.2.gem'
    sha256 '53d217666027eab4280346fba98e7d5b66baaae1b9c3c1c0ffe89d48188a3fbd'
  end

  resource 'concurrent-ruby' do
    url 'https://rubygems.org/downloads/concurrent-ruby-1.3.8.gem'
    sha256 'b2f1be836e968ccc78ccfce277ea79c72a88633f22306782c16ff23fb415d1e1'
  end

  # httparty requires csv without declaring it, and Ruby 3.4 dropped csv from
  # the default gems, so it has to be vendored alongside.

  resource 'csv' do
    url 'https://rubygems.org/downloads/csv-3.3.6.gem'
    sha256 'aba61e7e507a66f03d45cb1f3c4b6359861c3504038b422962875dce099e4456'
  end

  resource 'dotenv' do
    url 'https://rubygems.org/downloads/dotenv-2.8.1.gem'
    sha256 'c5944793349ae03c432e1780a2ca929d60b88c7d14d52d630db0508c3a8a17d8'
  end

  resource 'drb' do
    url 'https://rubygems.org/downloads/drb-2.2.3.gem'
    sha256 '0b00d6fdb50995fe4a45dea13663493c841112e4068656854646f418fda13373'
  end

  resource 'httparty' do
    url 'https://rubygems.org/downloads/httparty-0.21.0.gem'
    sha256 '00ef7bf9a71f30a3bff88edeb5b16a34bea883ab67c246b3f0db2d6794fe1214'
  end

  resource 'i18n' do
    url 'https://rubygems.org/downloads/i18n-1.15.2.gem'
    sha256 '00f9eb62412fe593b2a65a97daa75300d37abb8f7202ec748e94b6d46a9dd1b5'
  end

  resource 'mini_mime' do
    url 'https://rubygems.org/downloads/mini_mime-1.1.5.gem'
    sha256 '8681b7e2e4215f2a159f9400b5816d85e9d8c6c6b491e96a12797e798f8bccef'
  end

  resource 'minitest' do
    url 'https://rubygems.org/downloads/minitest-6.0.6.gem'
    sha256 '153ea36d1d987a62942382b61075745042a2b3123b1cd48f4c3675af9cc7d6f1'
  end

  resource 'multi_xml' do
    url 'https://rubygems.org/downloads/multi_xml-0.9.1.gem'
    sha256 '7ce766b59c17241ed62976caeae1fae9b2431b263398c35396239a68c4a64e57'
  end

  resource 'prism' do
    url 'https://rubygems.org/downloads/prism-1.9.0.gem'
    sha256 '7b530c6a9f92c24300014919c9dcbc055bf4cdf51ec30aed099b06cd6674ef85'
  end

  resource 'tzinfo' do
    url 'https://rubygems.org/downloads/tzinfo-2.0.6.gem'
    sha256 '8daf828cc77bcf7d63b0e3bdb6caa47e2272dcfaf4fbfe46f8c3a9df087a829b'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    # Installed in one call rather than one apiece, so that each gem's
    # dependencies are satisfied from the others here and nothing is fetched.

    resources.each(&:fetch)

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}
    libexec.install 'bin'

    # The gems are built by the ruby this depends on, and the script's
    # /usr/bin/env ruby would otherwise find whichever ruby comes first on the
    # user's PATH.  bigdecimal and prism carry compiled extensions, which are
    # built for one and will not load in the other.

    (bin/'git-checkout-new-issue').write_env_script(
      libexec/'bin/git-checkout-new-issue',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end

end
