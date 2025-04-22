class Mercurial < Formula

  desc "Wireguard server switcher."
  homepage 'https://github.com/thoran/mercurial'
  version '0.4.3'

  url 'https://github.com/thoran/mercurial.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/mercurial'
    lib.install 'lib/File/self.basename_without_extname.rb'
    lib.install 'lib/FileUtils/where.rb'
    lib.install 'lib/FileUtils/which.rb'
    lib.install 'lib/Files.rb'
    lib.install 'lib/Kernel/run.rb'
    lib.install 'lib/MacOS/IfConfig.rb'
    lib.install 'lib/Ordinal/Array.rb'
    lib.install 'lib/Platform/OS/OSX/SystemProfiler.rb'
    lib.install 'lib/Platform/OS/OSX.rb'
    lib.install 'lib/Platform/OS/linuxQ.rb'
    lib.install 'lib/Platform/OS/nt_basedQ.rb'
    lib.install 'lib/Platform/OS/osxQ.rb'
    lib.install 'lib/Platform/OS/windowsQ.rb'
    lib.install 'lib/Platform/OS.rb'
    lib.install 'lib/String/grep.rb'
    lib.install 'lib/Thoran/String/Capture/capture.rb'
    lib.install 'lib/Thoran/String/Captures/captures.rb'
    lib.install 'lib/Version.rb'
  end

end
