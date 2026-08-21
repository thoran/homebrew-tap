class Weblink < Formula
  desc "A CLI program for generating and converting weblink or web shortcut files."
  version '0.11.1'

  homepage 'https://github.com/thoran/weblink'
  url 'https://github.com/thoran/weblink.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/weblink'
  end
end
