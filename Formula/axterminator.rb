class Axterminator < Formula
  desc "Background-first macOS GUI automation with MCP server support"
  homepage "https://github.com/MikkoParkkola/axterminator"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/axterminator/releases/download/v0.8.0/axterminator-aarch64-apple-darwin"
      sha256 "b8e21d2bce850155ee0e3efa3703494b8d0ff0456dcc6630c12d749931e535cf"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/axterminator/releases/download/v0.8.0/axterminator-x86_64-apple-darwin"
      sha256 "4593519c71fa254c9be655cf7efbb15de61276e8c6655ab40a1c166113cdc0f6"
    end
  end

  def install
    # Release artifacts ship as a single bare binary, not an archive,
    # so install it directly under bin/axterminator.
    bin.install Dir["*"].first => "axterminator"
  end

  test do
    # `check` exits non-zero if accessibility is not granted, which is the
    # normal CI state, so just verify the binary runs and prints help.
    assert_match "axterminator", shell_output("#{bin}/axterminator --help")
  end
end
