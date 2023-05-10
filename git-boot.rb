class GitBoot < Formula

  desc "Create local and remote git repos with a single command."
  homepage 'https://github.com/thoran/git-boot'
  version '0.8.2'

  url 'https://github.com/thoran/git-boot.git'

  depends_on 'ruby'

  resource 'impuri' do
    url "https://rubygems.org/downloads/impuri-0.8.0.gem"
    sha256 "88ac2c67dfd2ecd222236e0f4bb8104c6b2b27607d8e42deb65b12b85e7a77f3"
  end

  resource 'net-ssh' do
    url 'https://rubygems.org/downloads/net-ssh-5.2.0.gem'
    sha256 '80a8a71d39e9f917ed265f66c0c5985f1849fc5e7156ac48f14dd1d4af683c80'
  end

  resource 'net-ssh-shell' do
    url 'https://rubygems.org/downloads/net-ssh-shell-0.2.0.gem'
    sha256 '27db7757ddcc49da67a29b12b082e46100e15a587fe89ee65438462d44dfbf23'
  end

  resource 'octokit' do
    url 'https://rubygems.org/downloads/octokit-4.18.0.gem'
    sha256 '26c24f2509e82da495a72df1aa36589dddf3c01251339746dcbac82a6dca6e7f'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.9.15.gem'
    sha256 '72a85f512a0e46d8316f4f606050731013c38e69e97544d7b7ce28f21aa122c0'
  end

  def install
    bin.install 'bin/git-boot'
  end

end
