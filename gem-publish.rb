class GemPublish < Formula
  desc "A simple Ruby script to build, push, and clean up gems in one step."
  homepage 'https://github.com/thoran/gem-publish'
  version '0.6.0'
  license 'MIT'

  url 'https://github.com/thoran/gem-publish.git', tag: 'v0.6.0', revision: '7a4aa7c586f9ca3eab4c54841429c64fcdd90118'

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
