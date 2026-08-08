class Exitor < Formula

  desc "Easily change tor exit node country."
  homepage 'https://github.com/thoran/exitor'
  version '0.3.0'

  url 'https://github.com/thoran/exitor.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/exitor'
  end

end
