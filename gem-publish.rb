class GemPublish < Formula
  desc "A simple shell script to build, push, and clean up a gem in one step."
  homepage 'https://github.com/thoran/gem-publish'
  version '0.5.0'
  license 'MIT'

  url 'https://github.com/thoran/gem-publish.git', tag: 'v0.5.0', revision: 'c084028224bf8adea3ca11b1ac9b8d954c224f58'

  def install
    bin.install 'bin/gem-publish'
  end
end
