class Cases < Formula

  desc "Show a list of the different cases used when coding."
  homepage 'https://github.com/thoran/cases'
  version '0.0.1'

  url 'https://github.com/thoran/cases.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/cases'
  end

end
