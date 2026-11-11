class ChshWrapper < Formula
  desc "Change the login shell, choosing from every copy of every shell installed."
  version '0.3.1'
  license 'MIT'

  homepage 'https://github.com/thoran/chsh-wrapper'
  url 'https://github.com/thoran/chsh-wrapper.git', tag: 'v0.3.1', revision: '356e10ca3679f17c8f76d623f75014af0b2d6173'

  depends_on 'ruby'

  # bin/chsh-wrapper requires readline alone, a bundled gem of the ruby this
  # depends upon, so nothing is vendored.

  def install
    libexec.install 'bin'

    # PATH names the ruby this depends on, the script's /usr/bin/env ruby
    # otherwise finding whichever comes first on the user's PATH.

    (bin/'chsh-wrapper').write_env_script(
      libexec/'bin/chsh-wrapper',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
    )
  end

  test do
    # Anything other than a shell's name goes to chsh as it is, so a stand-in
    # chsh shows what it was given.

    (testpath/'chsh').write("#!/bin/sh\necho \"chsh $*\"\n")
    chmod 0755, testpath/'chsh'
    ENV.prepend_path 'PATH', testpath
    assert_equal "chsh -s /bin/sh nobody\n", shell_output("#{bin}/chsh-wrapper -s /bin/sh nobody")
  end
end
