class ChromedriverInstall < Formula
  desc "Automatic selection and installation of the right chromedriver for your version of Chrome."
  homepage 'https://github.com/thoran/chromedriver-install'
  version '0.6.1'

  url 'https://github.com/thoran/chromedriver-install.git'

  depends_on 'ruby'
  depends_on 'xz' => :build

  resource 'http.rb' do
    url 'https://rubygems.org/downloads/http.rb-0.12.0.gem'
    sha256 '84862ca6ca8eb891ac87c8a07b43a85e700a3ed2141167f7473a1c8af078b145'
  end

  resource 'nokogiri' do
    url 'https://rubygems.org/downloads/nokogiri-1.13.9.gem'
    sha256 '96f37c1baf0234d3ae54c2c89aef7220d4a8a1b03d2675ff7723565b0a095531'
  end

  resource 'rubyzip' do
    url 'https://rubygems.org/downloads/rubyzip-3.2.2.gem'
    sha256 'c0ed99385f0625415c8f05bcae33fe649ed2952894a95ff8b08f26ca57ea5b3c'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s
    resources.each(&:fetch)

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}
    libexec.install 'bin', 'lib'

    # The gems are built by the ruby this depends on, and the script's
    # /usr/bin/env ruby would otherwise find whichever ruby comes first on the
    # user's PATH.  nokogiri's extension is built for one and will not load in
    # the other, so the wrapper names the ruby the gems were built against.

    (bin/'chromedriver-install').write_env_script(
      libexec/'bin/chromedriver-install',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
      RUBYLIB: libexec/'lib',
    )
  end
end
