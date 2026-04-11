class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, 33 tools, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "0.3.1"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.1/trvl_0.3.1_darwin_arm64.tar.gz"
      sha256 "c8c985d013b509ecb26406d6e6ffd091ec8b929b06dc1ff9013ae465f890957a"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.1/trvl_0.3.1_darwin_amd64.tar.gz"
      sha256 "4e9f9ea2ebbda35e2749f8515c0b74e34ad010861eccd8cbb327f6ea262c5a88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.1/trvl_0.3.1_linux_arm64.tar.gz"
      sha256 "2fb921e1e209458a4974e51d8e59f2d6c1f517e1a865bff704942724efc0f5ff"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.1/trvl_0.3.1_linux_amd64.tar.gz"
      sha256 "60c2b8e128a3dfd60749262a1822637a24a61ade438ecf9ef864f0c22b8af5f1"
    end
  end

  def install
    bin.install "trvl"
  end

  test do
    assert_match "trvl", shell_output("#{bin}/trvl version")
  end
end
