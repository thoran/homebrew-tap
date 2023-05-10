class GemHomepage < Formula

  desc "Open a gem's homepage from the command line."
  homepage 'https://github.com/thoran/gem-homepage'
  version '0.0.2'

  url 'https://github.com/thoran/gem-homepage.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/gem-homepage'
  end

end
