class GitMessages < Formula

  desc "Show the list of conventional commit types."
  homepage 'https://github.com/thoran/git-messages'
  version '0.2.0'

  url 'https://github.com/thoran/git-messages.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/git-messages'
  end

end
