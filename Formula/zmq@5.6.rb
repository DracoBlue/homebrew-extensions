# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT56 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura: "d109c24250ea21dae27e1005dc1e436dd1594f33a8a7db96117235ccb6f4a1be"
    sha256                               arm64_big_sur: "bf924e8fafddbdec7fef4df7c37e51449cf05224dd8eed2ffa6d6497061fd4ff"
    sha256 cellar: :any,                 ventura:       "97fe2b59b4a0791c5451a747cbf5cfe6881f75fe7f86c0b13bc96b772d2f700c"
    sha256                               big_sur:       "e7b10f6ccf7a02f7098556f42643ee4217213fa25cae13686a960937b1e183c0"
    sha256                               catalina:      "51def24ecff24cf221b601af7ce2d898904f1cfc991d159f818ac634ccf1af82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3d48b043c4e8ab0718a59d18637e0f87f76c69d327b23b123d57dfb858b3dd3"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["libsodium"].opt_prefix}/lib/pkgconfig"
    args = %W[
      prefix=#{prefix}
    ]
    on_macos do
      args << "--with-czmq=#{Formula["czmq"].opt_prefix}"
    end
    inreplace "package.xml", "@PACKAGE_VERSION@", version.to_s
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version.to_s
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version.to_s
    safe_phpize
    system "./configure", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
