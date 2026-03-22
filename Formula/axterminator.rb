class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  url "https://github.com/MikkoParkkola/axterminator/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "65f34371eeff736dbe2b6084b3d8ac0307b6c2906edd99268c891bebe05c306d"
  version "0.8.0"
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
