class Mercurial < Formula
  desc "Wireguard server switcher."
  homepage 'https://github.com/thoran/mercurial'
  version '0.11.2'

  url 'https://github.com/thoran/mercurial.git'

  depends_on 'ruby'

  # sys-proctable wants ffi, and the source gem rather than a prebuilt one, so
  # as the extension is built here for the ruby which will load it.

  resource 'ffi' do
    url 'https://rubygems.org/downloads/ffi-1.17.4.gem'
    sha256 'bcd1642e06f0d16fc9e09ac6d49c3a7298b9789bcb58127302f934e437d60acf'
  end

  # Ruby 4.0 dropped ostruct from the default gems, and two things here want it.
  # lib/Files.rb requires it and it is reached via Platform/OS/OSX, so it is
  # mercurial's own dependency. switches.rb also requires it. Without this
  # resource the program installs a gem into GEM_HOME at runtime, and the
  # wrapper points GEM_HOME at the keg, so it writes into its own installation
  # where brew neither put it nor knows of it.

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.10.3.gem'
    sha256 '2e0a8f74d28ef8f7ba21845f5eaefcde50ae32f924e36ae4493583d3ffaf9b1d'
  end

  resource 'sys-proctable' do
    url 'https://rubygems.org/downloads/sys-proctable-1.3.0.gem'
    sha256 '31f61ad79aa0d4412155132beadf2b7ca706a6badce4ad2dfeda5d1ca4916e54'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    # Installed in one call rather than one apiece, so that sys-proctable's
    # dependency upon ffi is satisfied from here and nothing is fetched.

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.fetch.to_s}

    # The whole tree, structure intact.  The eighteen lib.install lines this
    # replaces flattened every namespaced path — lib/MacOS/IfConfig.rb landed as
    # lib/IfConfig.rb, which require 'MacOS/IfConfig' could not find — and named
    # eighteen of the thirty-four files, omitting MacOS/VPN, File/self.grep and
    # Kernel/require_gem, each of which bin/mercurial requires.

    libexec.install 'bin', 'lib'

    # RUBYLIB reaches the vendored lib, which bin/mercurial requires without
    # putting on the load path itself.  PATH names the ruby the gems were built
    # against: ffi carries a compiled extension, which is built for one ruby and
    # will not load in another.

    (bin/'mercurial').write_env_script(
      libexec/'bin/mercurial',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
      RUBYLIB: libexec/'lib',
    )
  end
end
