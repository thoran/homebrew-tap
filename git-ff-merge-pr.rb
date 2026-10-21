class GitFfMergePr < Formula
  desc "Merge a branch's open pull request by fast-forwarding its base branch and pushing it."
  version '0.1.0'
  license 'MIT'

  homepage 'https://github.com/thoran/git-ff-merge-pr'
  url 'https://github.com/thoran/git-ff-merge-pr.git'

  depends_on 'gh'
  depends_on 'ruby'

  # git.rb and switches.rb are the gems bin/git-ff-merge-pr requires; ostruct is
  # switches.rb's own dependency and is named here so that nothing is fetched
  # during the build.  json is required too and is not here, being a default
  # gem: it ships with the ruby this depends upon rather than living in the gems
  # directory, so the GEM_PATH the wrapper sets does not shut it out.

  resource 'git.rb' do
    url 'https://rubygems.org/downloads/git.rb-0.15.1.gem'
    sha256 '3d00113b2e8babe720985248c4cbc9ab9e0c7255801bfdb1d9ff90a9c2032543'
  end

  resource 'ostruct' do
    url 'https://rubygems.org/downloads/ostruct-0.6.3.gem'
    sha256 '95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912'
  end

  resource 'switches.rb' do
    url 'https://rubygems.org/downloads/switches.rb-0.14.0.gem'
    sha256 'b6c0fa8c22277fd40c3070864040da75bc48086012d8db8b3fdc88a50c7f312a'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    # Installed with --local and --ignore-dependencies, the resources being the
    # whole of what is needed.  gem install resolves a file's dependencies from
    # what is already installed and from the remote, not from the other files
    # it was given, so without these each dependency named later in the list
    # than a gem needing it would be fetched, at whichever version is newest.

    system 'gem', 'install', '--local', '--ignore-dependencies', '--no-document',
      '--install-dir', libexec/'vendor', *resources.map{|r| r.cached_download.to_s}

    libexec.install 'bin'

    # GEM_HOME and GEM_PATH reach the vendored gems.  PATH names the ruby this
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
