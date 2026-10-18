class GitFfMergePr < Formula
  desc "Merge a branch's open pull request by fast-forwarding its base branch and pushing it."
  version '0.0.0'
  license 'MIT'

  homepage 'https://github.com/thoran/git-ff-merge-pr'
  url 'https://github.com/thoran/git-ff-merge-pr.git'

  depends_on 'gh'
  depends_on 'ruby'

  # git.rb is the only gem bin/git-ff-merge-pr requires.  json is required too
  # and is not here, being a default gem: it ships with the ruby this depends
  # upon rather than living in the gems directory, so the GEM_PATH the wrapper
  # sets does not shut it out.

  resource 'git.rb' do
    url 'https://rubygems.org/downloads/git.rb-0.15.1.gem'
    sha256 '3d00113b2e8babe720985248c4cbc9ab9e0c7255801bfdb1d9ff90a9c2032543'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}

    libexec.install 'bin'

    # GEM_HOME and GEM_PATH reach the vendored gem.  PATH names the ruby this
    # depends on, the script's /usr/bin/env ruby otherwise finding whichever
    # comes first on the user's PATH — which matters here beyond the usual, json
    # being a default gem of that ruby rather than something vendored.

    (bin/'git-ff-merge-pr').write_env_script(
      libexec/'bin/git-ff-merge-pr',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end
end
