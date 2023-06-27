class GitAutobisect < Formula

  desc "Automate git bisect."
  homepage 'https://github.com/thoran/git-bisect'
  version '0.3.2'

  url 'https://github.com/thoran/git-autobisect.git'

  depends_on 'ruby'

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.9.15.gem'
    sha256 '72a85f512a0e46d8316f4f606050731013c38e69e97544d7b7ce28f21aa122c0'
  end

  def install
    bin.install 'bin/git-autobisect'
  end

end
