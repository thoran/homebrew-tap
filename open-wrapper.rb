class OpenWrapper < Formula
  desc "Extend macOS' open with shortcuts which open one or more things at once."
  version '0.1.5'
  license 'MIT'

  homepage 'https://github.com/thoran/open-wrapper'
  url 'https://github.com/thoran/open-wrapper.git', tag: 'v0.1.5', revision: '694061bd0d256987cf04f0f6e9d4299970b8b921'

  depends_on :macos
  depends_on 'ruby'

  # bin/open-wrapper requires nothing outside Ruby's core, so nothing is vendored.

  def install
    libexec.install 'bin'
    pkgshare.install 'examples'

    # PATH names the ruby this depends on, the script's /usr/bin/env ruby
    # otherwise finding whichever comes first on the user's PATH.

    (bin/'open-wrapper').write_env_script(
      libexec/'bin/open-wrapper',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
    )
  end

  def caveats
    <<~EOS
      To use it in place of open, alias it:
        alias open='open-wrapper'

      An example config is in #{opt_pkgshare}/examples/config.rb:
        mkdir -p ~/.config/open-wrapper
        cp #{opt_pkgshare}/examples/config.rb ~/.config/open-wrapper/config.rb
    EOS
  end

  test do
    # With no config there are no shortcuts, and everything goes to open as it
    # is, so a stand-in open shows what it was given.

    (testpath/'open').write("#!/bin/sh\necho \"open $*\"\n")
    chmod 0755, testpath/'open'
    ENV.prepend_path 'PATH', testpath
    assert_equal "open -a Finder .\n", shell_output("#{bin}/open-wrapper -a Finder .")
    assert_path_exists pkgshare/'examples/config.rb'
  end
end
