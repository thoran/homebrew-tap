class Skyhooks < Formula
  desc "Automatically swap references from FactoryBot's create to build in tests to speed up test runs by using in-memory objects (in the sky) rather than hitting the database (down below)."
  homepage 'https://github.com/thoran/skyhooks'
  version '0.4.1'

  url 'https://github.com/thoran/skyhooks.git'

  depends_on 'ruby'

  # The four lib.install lines this replaces were commented out and nothing put
  # in their place, so no lib reached the keg at all.  They would not have
  # served either: lib.install of a file installs it by its basename, so
  # 'lib/Array/match.rb' arrives as lib/match.rb and the require of
  # 'Array/match' cannot find it.

  # PATH, GEM_HOME and GEM_PATH are not set, skyhooks declaring no resource and
  # requiring nothing but its own lib and fileutils.  RUBYLIB is belt and
  # braces: bin/skyhooks puts its own '..', 'lib' on the load path already, and
  # inside libexec that resolves.

  def install
    libexec.install 'bin', 'lib'

    (bin/'skyhooks').write_env_script(
      libexec/'bin/skyhooks',
      RUBYLIB: libexec/'lib',
    )
  end
end
