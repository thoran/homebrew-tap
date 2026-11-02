class Changelogger < Formula
  desc "Given a directory of numbered revisions, write a cumulative CHANGELOG into each of them."
  homepage 'https://github.com/thoran/changelogger'
  version '0.24.0'
  license 'MIT'

  url 'https://github.com/thoran/changelogger.git', tag: 'v0.24.0', revision: '47ed3014a8b089858757531d244c07329ff1f70c'

  depends_on 'ruby'

  def install
    bin.install 'bin/changelogger'
  end
end
