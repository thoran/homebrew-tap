class ChromedriverInstall < Formula

  desc "Automatic selection and installation of the right chromedriver for your version of Chrome."
  homepage 'https://github.com/thoran/chromedriver-install'
  version '0.3.1'

  url 'https://github.com/thoran/chromedriver-install.git'

  depends_on 'ruby'

  resource 'http.rb' do
    url 'https://rubygems.org/downloads/http.rb-0.12.0.gem'
    sha256 '84862ca6ca8eb891ac87c8a07b43a85e700a3ed2141167f7473a1c8af078b145'
  end

  resource 'nokogiri' do
    url 'https://rubygems.org/downloads/nokogiri-1.13.9.gem'
    sha256 '96f37c1baf0234d3ae54c2c89aef7220d4a8a1b03d2675ff7723565b0a095531'
  end

  resource 'rubyzip' do
    url 'https://rubygems.org/downloads/rubyzip-2.3.2.gem'
    sha256 '3f57e3935dc2255c414484fbf8d673b4909d8a6a57007ed754dde39342d2373f'
  end

  def install
    bin.install 'bin/chromedriver-install'
    lib.install 'lib/Module/alias_methods.rb'
    lib.install 'lib/Ordinal/Array.rb'
    lib.install 'lib/Ordinal.rb'
    lib.install 'lib/String/matches.rb'
    lib.install 'lib/Thoran/Module/AliasMethods/alias_methods.rb'
    lib.install 'lib/Thoran/String/Capture/capture.rb'
    lib.install 'lib/Version.rb'
  end

end
