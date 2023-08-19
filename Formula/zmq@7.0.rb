# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT70 < AbstractPhpExtension
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
    sha256                               arm64_big_sur: "b1d3a8b5d55612ae25eb0d8e1cef0f3d6c0e444bdd3aef2fd197a0f043ff3fe2"
    sha256 cellar: :any,                 ventura:       "51010ff55904f831f28f7724ada6794f04c9aa0b521c1c37fa73309481e63b4d"
    sha256                               big_sur:       "c0be166a610e23a8c8f22a6cabe7ad53ab2085e7028e92ce9ff0212f5ed66ad8"
    sha256                               catalina:      "684ddfafcef1a8e68929bf6385a635c3b48ad73593226d689a9f71e113c8048a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64ff7cc9d86f71449f54481843cebd32ead69ae605c0c73d2e56de3eca130a36"
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
