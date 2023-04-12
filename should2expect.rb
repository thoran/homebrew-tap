class Should2expect < Formula

  desc "Automatically convert Rspec should-style to expect-style expectations."
  homepage 'https://github.com/thoran/dehashrocketify'
  version '0.13.1'

  url 'https://github.com/thoran/should2expect.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/should2expect'
  end

end
