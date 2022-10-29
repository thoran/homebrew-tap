class Jira < Formula

  desc "Easily open an issue on Atlassian's Jira issue tracker from the CLI."

  homepage 'https://github.com/thoran/jira'
  version '0.3.0'

  url 'https://github.com/thoran/jira.git'

  depends_on 'ruby'

  resource 'git.rb' do
    url 'https://rubygems.org/downloads/git.rb-0.10.0.gem'
    sha256 '1db4de8f1123546f67072b473c1f67d9b5973ca30a678990ec87b164ae01ac01'
  end

  def install
    bin.install 'bin/jira'
    lib.install Dir['lib/**/*']
  end

end
