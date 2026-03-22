class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  url "https://github.com/MikkoParkkola/axterminator/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "b60c64c7f11e83b79a6ed16a895fb33c6b504c29a99fb999bc66a5ecd9dc76ea"
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
