class GemPublish < Formula
  desc "A simple shell script to build, push, and clean up a gem in one step."
  homepage 'https://github.com/thoran/gem-publish'
  version '0.2.1'
  license 'MIT'

  url 'https://github.com/thoran/gem-publish.git'

  def install
    bin.install 'bin/gem-publish'
  end
end
