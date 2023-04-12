class Dehashrocketify < Formula

  desc "Hashrockets be gone!"
  homepage 'https://github.com/thoran/dehashrocketify'
  version '0.11.1'

  url 'https://github.com/thoran/dehashrocketify.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/dehashrocketify'
  end

end
