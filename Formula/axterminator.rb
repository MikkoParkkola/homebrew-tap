class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/MikkoParkkola/axterminator/releases/download/v0.9.0/axterminator-aarch64-apple-darwin"
    sha256 "42f0f40077a351abdda16870aeb1c39a4a01f29cb61f3ac7fbbdebb263c3268d"
  else
    url "https://github.com/MikkoParkkola/axterminator/releases/download/v0.9.0/axterminator-x86_64-apple-darwin"
    sha256 "62eb29e752d9157de3d07f86aada41e464d898d17cb6dc4aa13e9cf07529e643"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "axterminator-aarch64-apple-darwin" => "axterminator"
    else
      bin.install "axterminator-x86_64-apple-darwin" => "axterminator"
    end
  end

  test do
    assert_match "accessibility", shell_output("#{bin}/axterminator check")
  end
end
