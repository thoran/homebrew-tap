class Changelogger < Formula
  desc "Given a directory of numbered revisions, write a cumulative CHANGELOG into each of them."
  homepage 'https://github.com/thoran/changelogger'
  version '0.12.0'
  license 'MIT'

  url 'https://github.com/thoran/changelogger.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/changelogger'
  end
end
