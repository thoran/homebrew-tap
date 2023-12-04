class Whale < Formula

  desc "Sometimes when they go fishing, they get a whale and it sinks their boat."
  homepage 'https://github.com/thoran/whale'
  version '0.8.0'

  url 'https://github.com/thoran/whale.git'

  depends_on 'ruby'

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.9.15.gem'
    sha256 '72a85f512a0e46d8316f4f606050731013c38e69e97544d7b7ce28f21aa122c0'
  end

  resource 'mechanize' do
    url 'https://rubygems.org/downloads/mechanize-2.9.1.gem'
    sha256 '1f2026cd90395a95002fa1653c13120bf7228facda970a011e19c5c7f1a08c22'
  end

  def install
    bin.install 'bin/whale'
    FileUtils.cp_r("#{pwd}/lib", lib)
  end

end
