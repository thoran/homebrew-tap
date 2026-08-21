class Exitor < Formula
  desc "Easily change tor exit node country."
  homepage 'https://github.com/thoran/exitor'
  version '0.5.1'

  url 'https://github.com/thoran/exitor.git'

  depends_on 'ruby'

  # bin/exitor requires csv, http.rb and sys/proctable, and install() put the
  # script into the keg with none of the three beside it, so a fresh install
  # reached the first of them and stopped there.  ffi comes in with
  # sys-proctable, and is named here so that nothing is fetched during the
  # build.  csv was a default gem until Ruby 3.4 and is a bundled one since,
  # which is a thing to be shipped rather than assumed.

  resource 'csv' do
    url 'https://rubygems.org/downloads/csv-3.3.6.gem'
    sha256 'aba61e7e507a66f03d45cb1f3c4b6359861c3504038b422962875dce099e4456'
  end

  resource 'ffi' do
    url 'https://rubygems.org/downloads/ffi-1.17.4.gem'
    sha256 'bcd1642e06f0d16fc9e09ac6d49c3a7298b9789bcb58127302f934e437d60acf'
  end

  resource 'http.rb' do
    url 'https://rubygems.org/downloads/http.rb-0.12.0.gem'
    sha256 '84862ca6ca8eb891ac87c8a07b43a85e700a3ed2141167f7473a1c8af078b145'
  end

  resource 'sys-proctable' do
    url 'https://rubygems.org/downloads/sys-proctable-1.3.0.gem'
    sha256 '31f61ad79aa0d4412155132beadf2b7ca706a6badce4ad2dfeda5d1ca4916e54'
  end

  def install
    ENV['GEM_HOME'] = (libexec/'vendor').to_s
    ENV['GEM_PATH'] = (libexec/'vendor').to_s

    # Installed in one call rather than one apiece, so that sys-proctable's
    # dependency upon ffi is satisfied from here and nothing is fetched.

    resources.each(&:fetch)

    system 'gem', 'install', '--no-document', '--install-dir', libexec/'vendor',
      *resources.map{|r| r.cached_download.to_s}

    libexec.install 'bin'

    # GEM_HOME and GEM_PATH reach the four vendored gems, and shut out the gem
    # home the invoking shell has, that one having been built for another ruby.
    # PATH names the ruby the gems were built against: ffi carries a compiled
    # extension, which is built for one ruby and will not load in another.

    (bin/'exitor').write_env_script(
      libexec/'bin/exitor',
      PATH: "#{Formula['ruby'].opt_bin}:$PATH",
      GEM_HOME: libexec/'vendor',
      GEM_PATH: libexec/'vendor',
    )
  end
end
