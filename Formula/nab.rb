class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.0/nab-aarch64-apple-darwin"
      sha256 "a59238f7e39e2e8c05e960d54abcafe1786dd69252021a95b1c4dd696cff2360"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.0/nab-x86_64-apple-darwin"
      sha256 "c8f72c252dd330f5e68f2f39ae146258dc8567e738cf7153ca88ce449de969c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.0/nab-aarch64-unknown-linux-gnu"
      sha256 "fc030caa49380a1599cf237dbddcf3fde81f113f960a0946904ccd4793727869"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.0/nab-x86_64-unknown-linux-gnu"
      sha256 "657a89e6bee98d1d74f6b0c92964898d51a938270cfc5bb44cf409b1ffa92869"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "nab-aarch64-apple-darwin" => "nab"
      else
        bin.install "nab-x86_64-apple-darwin" => "nab"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "nab-aarch64-unknown-linux-gnu" => "nab"
      else
        bin.install "nab-x86_64-unknown-linux-gnu" => "nab"
      end
    end
  end

  def post_install
    system bin/"nab", "upgrade", "--quiet"
  end

  test do
    assert_match "nab", shell_output("#{bin}/nab --version")
  end
end
