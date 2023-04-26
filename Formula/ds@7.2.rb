# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT72 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.3.0.tgz"
  sha256 "0114b146e1036d75a83cd438200df73db030b5d12b8c687843809d1d0cec91be"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cde2f03b4330b3d2eaadeb32b5d7a1724570b97190649bade86b4c70b13f8a6e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7d8e486da66159381e50623647a6f7433251c06ed935aabd8d63172a67d979d2"
    sha256 cellar: :any_skip_relocation, ventura:        "9ae944ff33ef2c47b5aa66281e21fc7e1e4bb9d35b3399c759b8f52ae488627d"
    sha256 cellar: :any_skip_relocation, monterey:       "e82fe3259c7cb7547ffe08106208fecf540bfdef290d1e4e4dc5d2824e82531a"
    sha256 cellar: :any_skip_relocation, big_sur:        "017fc0d462734fb6830474bee8023fad330e4bbc9c90fbccb3c09f40d87ec663"
    sha256 cellar: :any_skip_relocation, catalina:       "55c6d408822cb019436637d1d3a27979e8e704b8c91c51792948ea6723d9bfaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8208feae2417069788f14a863fa025a1f7f38958f38c5f1462a70d8bb4e03ac"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
