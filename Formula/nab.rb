class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.0/nab-aarch64-apple-darwin"
      sha256 "1fa2f3332fc1e70840c0e7527258a05f9f030bb9600194896de65fab59472748"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.0/nab-x86_64-apple-darwin"
      sha256 "1eb88440ead6a0c66dae4cecc5e4d18f748b856ba5da0d6d49a606aaad965922"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.0/nab-aarch64-unknown-linux-gnu"
      sha256 "6327a4fd6b9fc96c90da2dd2eb251665731c5720ac71c29eae2d5f386dae2c83"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.0/nab-x86_64-unknown-linux-gnu"
      sha256 "e89bd03c8879b28c65447dd78f3a8155fb086d19db59c7c2b842b4335afe9802"
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
    system "xattr", "-dr", "com.apple.quarantine", "#{bin}/nab" if OS.mac?
  rescue
    nil
  end

  test do
    assert_match "nab", shell_output("#{bin}/nab --version")
  end
end
