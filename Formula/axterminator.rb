class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  url "https://github.com/MikkoParkkola/axterminator/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "cb02a262ac5c26eadb2efb65cef72a6fcc7d8f1f68f03341b8a1abfa99a7093c"
  version "0.5.0"
  license "MIT OR Apache-2.0"

  depends_on :macos
  depends_on "rust" => :build

  def install
    system "cargo", "install",
      "--locked",
      "--features", "cli",
      "--root", prefix,
      "--path", "."
  end

  test do
    assert_match "accessibility", shell_output("#{bin}/axterminator check")
  end
end
