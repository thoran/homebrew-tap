class Startor < Formula

  desc "Easily install, start, and stop tor."
  homepage 'https://github.com/thoran/startor'
  version '0.7.0'

  url 'https://github.com/thoran/startor.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/startor'
  end

end
