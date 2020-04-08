class Ci < Formula

  desc 'Open ci from the cli.'
  homepage 'https://github.com/thoran/ci'
  version '0.1.3'
  bottle :unneeded

  url 'https://github.com/thoran/ci.git'

  depends_on 'ruby'

  resource 'git.rb' do
    url 'https://rubygems.org/downloads/git.rb-0.10.0.gem'
    sha256 '1db4de8f1123546f67072b473c1f67d9b5973ca30a678990ec87b164ae01ac01'
  end

  resource 'impuri' do
    url 'https://rubygems.org/downloads/impuri-0.8.0.gem'
    sha256 '88ac2c67dfd2ecd222236e0f4bb8104c6b2b27607d8e42deb65b12b85e7a77f3'
  end

  def install
    bin.install 'bin/ci'
  end

end
