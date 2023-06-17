# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT71 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "d426ba70f2f72603502222549ca69ea174488d4114a30621aa944bdb5b51b454"
    sha256 cellar: :any,                 arm64_big_sur:  "b6ba7f0a12cf88ad5f32b5b146e7eb9b5f0720261d5630cf2ef58c475696fd32"
    sha256 cellar: :any,                 ventura:        "fe8499f4a8ce23f0fae3dc13c89c968c4cde8f03d199f938713f0d0bfd5d915d"
    sha256 cellar: :any,                 monterey:       "614d6ac31ce7a2e8ca4321c1197528d407ab2e8fc63882e9c2dcc6e95e01127a"
    sha256 cellar: :any,                 big_sur:        "39444d76f907cc18c704ffda079ca76b87d12b0dab0b866f0d75348f145f5efd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bfdf0ca4ef97bd1994f8ef8431372503d1e44b33273677b311820f20fa5cdd56"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
