# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT82 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.0.tgz"
  sha256 "ee3d4f67e24d82e4d340806a24052012e4954d223122949377665427443e6d13"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c644d3f12bef950ca3c4db91ae24bd2c5c44bf44e2f0a98ceed324da0a333fe4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "129b5308e60ed6b7288a4a6b702923ee927793b40c35e99729b65bf7448f28fb"
    sha256 cellar: :any_skip_relocation, ventura:        "06f48d5983257f36a9a14327e3a8897b63385095ad2120ad3af2a215352642f7"
    sha256 cellar: :any_skip_relocation, monterey:       "a6fd5c9f3a358d5b3a6b4a70f58d68d4237f5887ef855c8b3ca762e0b6614b8f"
    sha256 cellar: :any_skip_relocation, big_sur:        "e5c615a1729c169ab66edfe1eda32419e8cc96a543d524e7fe88fe0f2f8baa91"
    sha256 cellar: :any_skip_relocation, catalina:       "e08f9c54c678d22d63c4dcac14f3ec64e7ccb0fa4c1987c50fb62a14466c0167"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "92760bd0d2e1042abb5ad3373806686fde33b5d031c2de3346c6ee6e1fb192eb"
  end

  def install
    Dir.chdir "ast-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ast"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
