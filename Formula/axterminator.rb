class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  url "https://github.com/MikkoParkkola/axterminator/archive/refs/tags/v0.10.1.tar.gz"
  version "0.10.1"
  sha256 "d05cc9a01e10583d3e3a52bf9051c549aee4c3c49cfc62aa370b093db1eed137"
  license :cannot_represent

  depends_on "rust" => :build
  depends_on :macos

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
