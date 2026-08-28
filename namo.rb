class Namo < Formula
  desc "Named dimensional data for Ruby."
  homepage 'https://github.com/thoran/namo'
  version '0.32.0'
  license 'MIT'

  url 'https://github.com/thoran/namo.git'

  depends_on 'ruby'

  # bin and lib stay siblings in libexec so that bin/console's own
  # require_relative '../lib/namo' resolves inside namo rather than in the shared
  # prefix, as moby's does.
  #
  # No resources: namo has no runtime dependency at all.  measurand is optional —
  # the demo's uncertainty section does without it — and `namo setup` installs it,
  # along with the gem, which is what makes require 'namo' work outside this keg.
  #
  # PATH names the ruby this depends on, the scripts' own /usr/bin/env ruby
  # otherwise finding whichever comes first on the user's PATH.
  def install
    libexec.install 'bin', 'lib'

    (bin/'namo').write_env_script(
      libexec/'bin/namo',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
    )
  end
end
