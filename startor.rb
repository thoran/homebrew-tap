class Startor < Formula
  desc "Easily install, start, and stop tor."
  homepage 'https://github.com/thoran/startor'
  version '0.8.0'

  url 'https://github.com/thoran/startor.git'

  depends_on 'ruby'

  # Ruby 4.0 dropped ostruct from the default gems, and lib/Files.rb requires it
  # for OpenStruct.  Files.rb is reached through Platform/OS/OSX, so it is
  # startor's own dependency and not one inherited from a gem.

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.fetch.to_s}

    libexec.install 'bin', 'lib'

    # RUBYLIB is what makes the vendored lib reachable: bin/startor requires
    # 'FileUtils/which', 'Kernel/run', 'MacOS/HardwarePort' and 'MacOS/IfConfig'
    # without putting lib on the load path itself, so without this they resolve
    # only where RUBYLIB already happens to supply them.  bin.install had left
    # lib uninstalled altogether, so the four resolved from the invoking ruby's
    # RUBYLIB or not at all.  PATH names the ruby this depends on, there being
    # no gem here for it to matter to, only the script's own /usr/bin/env ruby.
    #
    # GEM_HOME and GEM_PATH reach the vendored ostruct, and shut out the gem
    # home the invoking shell has: that one was built for another ruby, so
    # RubyGems warns upon every gem there carrying an extension before startor
    # prints a word of its own.

    (bin/'startor').write_env_script(
      libexec/'bin/startor',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
      RUBYLIB: libexec/'lib',
    )
  end
end
