class Jira < Formula
  desc "Easily open an issue on Atlassian's Jira issue tracker from the CLI."
  homepage 'https://github.com/thoran/jira'
  version '0.5.0'

  url 'https://github.com/thoran/jira.git'

  depends_on 'ruby'

  resource 'git.rb' do
    url 'https://rubygems.org/downloads/git.rb-0.14.1.gem'
    sha256 '6742e7a5530be754a44b5831aa282b72a64973a7ae3f160777e09e306ea383ff'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s
    resources.each do |r|
      r.fetch
      system 'gem', 'install', r.cached_download, '--no-document', '--install-dir', libexec/'vendor'
    end
    libexec.install 'bin'

    # The gems are built by the ruby this depends on, and the script's
    # /usr/bin/env ruby would otherwise find whichever ruby comes first on the
    # user's PATH. git.rb is pure Ruby and would load either way; this is here
    # so that it still does the day it is not.

    (bin/'jira').write_env_script(
      libexec/'bin/jira',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end
end
