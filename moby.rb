class Moby < Formula
  desc "Sometimes when they go fishing, they get a whale and it sinks their boat."
  homepage 'https://github.com/thoran/moby'
  version '2.1.0'

  url 'https://github.com/thoran/moby.git'

  depends_on 'ruby'

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.9.15.gem'
    sha256 '72a85f512a0e46d8316f4f606050731013c38e69e97544d7b7ce28f21aa122c0'
  end

  resource 'mechanize' do
    url 'https://rubygems.org/downloads/mechanize-2.9.1.gem'
    sha256 '1f2026cd90395a95002fa1653c13120bf7228facda970a011e19c5c7f1a08c22'
  end

  # The whole tree into libexec, bin and lib staying siblings there so that
  # bin/moby's own '..', 'lib' resolves inside moby rather than in the shared
  # prefix.  The cp_r this replaces put Moby.rb, Moby/, Selenium/ and Thoran/
  # into HOMEBREW_PREFIX/lib, where Thoran/ is a real directory shared with
  # whatever else lands there and Selenium/ is the selenium-webdriver gem's own
  # namespace.

  # GEM_HOME and GEM_PATH are deliberately not set, and neither is PATH.  The
  # two resources below are declared and never installed, so moby resolves
  # switches.rb and mechanize from whichever gem home the invoking ruby has;
  # pointing GEM_HOME at an empty libexec/vendor, or PATH at a ruby without
  # those gems, would each turn a working install into a broken one.  Vendoring
  # them is the rest of this job and wants mechanize's closure resolved first.

  def install
    libexec.install 'bin', 'lib'

    (bin/'moby').write_env_script(
      libexec/'bin/moby',
      RUBYLIB: libexec/'lib',
    )
  end
end
