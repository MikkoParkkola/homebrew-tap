class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, 32 tools, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "0.3.0"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.0/trvl_0.3.0_darwin_arm64.tar.gz"
      sha256 "3029e96b7ea22c7f8733adc3d479cfcca5cdb1dbd3859d5af2df625bca65ba89"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.0/trvl_0.3.0_darwin_amd64.tar.gz"
      sha256 "d2581ce68f29e011078af854797418d4881c1b465f8b353aa477f43e72d406b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.0/trvl_0.3.0_linux_arm64.tar.gz"
      sha256 "d05a2605b68690358d7a7c5a502f7614a457beb45c4bbef8eb45570c98acc0a6"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/trvl/releases/download/v0.3.0/trvl_0.3.0_linux_amd64.tar.gz"
      sha256 "038b43fcaa22094f36937f5c0df1a6a33b8f303533caf42da19fd6cece121748"
    end
  end

  def install
    bin.install "trvl"
  end

  test do
    assert_match "trvl", shell_output("#{bin}/trvl version")
  end
end
