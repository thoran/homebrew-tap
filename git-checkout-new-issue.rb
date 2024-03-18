class GitCheckoutNewIssue < Formula

  desc "Create a new branch at the same time as creating a new issue. Only works with Jira for now."
  homepage 'https://github.com/thoran/git-checkout-new-issue'
  version '0.2.0'

  url 'https://github.com/thoran/git-checkout-new-issue.git'

  depends_on 'ruby'

  resource 'activesupport' do
    url 'https://rubygems.org/downloads/activesupport-7.0.7.2.gem'
    sha256 '62e01393689c8514a65e2cf8be6f4781d1e6c7d9adc25b1056902d8abd659fee'
  end

  resource 'dotenv' do
    url 'https://rubygems.org/downloads/dotenv-2.8.1.gem'
    sha256 'c5944793349ae03c432e1780a2ca929d60b88c7d14d52d630db0508c3a8a17d8'
  end

  resource 'httparty' do
    url 'https://rubygems.org/downloads/httparty-0.21.0.gem'
    sha256 '00ef7bf9a71f30a3bff88edeb5b16a34bea883ab67c246b3f0db2d6794fe1214'
  end

  def install
    bin.install 'bin/git-checkout-new-issue'
  end

end
