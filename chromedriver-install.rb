class ChromedriverInstall < Formula
  desc "Automatic selection and installation of the right chromedriver for your version of Chrome."
  homepage 'https://github.com/thoran/chromedriver-install'
  version '0.7.1'

  url 'https://github.com/thoran/chromedriver-install.git'

  depends_on 'ruby'
  depends_on 'xz' => :build

  resource 'http.rb' do
    url 'https://rubygems.org/downloads/http.rb-1.3.2.gem'
    sha256 '33b8ecc2c5ff03af1a67f3ccce272c7945af376d7921f465321d435bec924c35'
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
