class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-aarch64-apple-darwin"
      sha256 "c0b7e80d9295ae55349dbf4cac6bcc34f7da3c52eef8c18e7dde9307d888a518"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-x86_64-apple-darwin"
      sha256 "b5c9543bc1b1a44ba37d1e8ede19e45b4bfd58f580fcb1ea0292640650d8f8b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-aarch64-unknown-linux-gnu"
      sha256 "0d224d19da284ba9c8c8cb98e2a8a855eb1e747465f95cac1b59a938c3ad3411"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-x86_64-unknown-linux-gnu"
      sha256 "93e1ee6640b78d47598471115d7577588181403ae413e0dd9e583046166ca104"
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

  test do
    assert_match "nab", shell_output("#{bin}/nab --version")
  end
end
