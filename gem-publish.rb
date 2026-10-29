class GemPublish < Formula
  desc "A simple Ruby script to build, push, and clean up gems in one step."
  homepage 'https://github.com/thoran/gem-publish'
  version '0.7.0'
  license 'MIT'

  url 'https://github.com/thoran/gem-publish.git', tag: 'v0.7.0', revision: 'd4df9730be93561ea37bd2d793b711ed1c028032'

  depends_on 'ruby'

  def install
    libexec.install 'bin'

    # PATH names the ruby it is run with, Homebrew's being keg-only, and so the
    # gem it pushes with.

    (bin/'gem-publish').write_env_script(
      libexec/'bin/gem-publish',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
    )
  end
end
