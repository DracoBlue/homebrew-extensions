# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT56 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-1.0.2.tgz"
  sha256 "6b4e785adcc8378148c7ad06aa82e71e1d45c7ea5dbebea9ea9a38fee14e62e7"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a3f2e3c010769b49a2ab6ef07873362969b802c12c921f9c65471bf04897467c"
    sha256 cellar: :any_skip_relocation, monterey:      "4ac8a2f6c85dc1216c4c1b722130c148e0a5df66beab24b38bad66f6bf746cbc"
    sha256 cellar: :any_skip_relocation, big_sur:       "b3081c164ea776c264f740a8b6a36de5175ae809466db55fe0ed00d98c9b8e0d"
    sha256 cellar: :any_skip_relocation, catalina:      "a218bca11d1d3923ad2ccbe0142f73f0c04273d7effc3f04a7cff7a96a458767"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ece6bc1161c7adcf599a0f6402e739ed64cc060d4a8bce6004547e9236ad966"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
