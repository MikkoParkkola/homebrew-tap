class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  url "https://github.com/MikkoParkkola/axterminator/archive/refs/tags/v0.11.1.tar.gz"
  sha256 "170f00090685ee121440e843922e1b845610a4745494db1989c93110c9d9aa5d"
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
