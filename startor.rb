class Startor < Formula
  desc "Easily install, start, and stop tor."
  homepage 'https://github.com/thoran/startor'
  version '0.10.0'

  url 'https://github.com/thoran/startor.git'

  depends_on 'ruby'

  def install
    libexec.install 'bin', 'lib'

    # 0.10.0 dropped lib/Files.rb, which was the one thing here requiring
    # ostruct, so the resource which supplied it, the gem install which put it
    # in place and the GEM_HOME and GEM_PATH which reached it all go with it.
    # bin/startor and the ten library files left ask for no gem at all.
    #
    # RUBYLIB is what makes the vendored lib reachable: bin/startor requires
    # 'FileUtils/which', 'Kernel/run', 'MacOS/HardwarePort' and 'MacOS/IfConfig'
    # without putting lib on the load path itself, so without this they resolve
    # only where RUBYLIB already happens to supply them.  PATH names the ruby
    # this depends on, the script's own /usr/bin/env ruby otherwise finding
    # whichever comes first on the user's PATH.

    (bin/'startor').write_env_script(
      libexec/'bin/startor',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      RUBYLIB: libexec/'lib',
    )
  end
end
