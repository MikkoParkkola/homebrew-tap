class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  url "https://github.com/MikkoParkkola/axterminator/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "899ade490ed0ad91f7ad851e23697904923f074b4bea78964f9ca031090fdd13"
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
