class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  url "https://github.com/MikkoParkkola/axterminator/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "ed6c8e4843801ad482cb32e0be496fb481b8a93031858b2829329cfeb17fea5b"
  version "0.7.1"
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
