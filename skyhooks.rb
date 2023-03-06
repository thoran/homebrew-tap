class Skyhooks < Formula

  desc "Automatically swap references from FactoryBot's create to build in tests to speed up test runs by using in-memory objects (in the sky) rather than hitting the database (down below)."
  homepage 'https://github.com/thoran/skyhooks'
  version '0.3.1'

  url 'https://github.com/thoran/skyhooks.git'

  depends_on 'ruby'

  def install
    bin.install 'bin/skyhooks'
    # lib.install 'lib/Array/match.rb'
    # lib.install 'lib/File/self.gsubX.rb'
    # lib.install 'lib/Thoran/Array/Match/match.rb'
    # lib.install 'lib/Thoran/File/SelfGsubX/self.gsubX.rb'
  end

end
