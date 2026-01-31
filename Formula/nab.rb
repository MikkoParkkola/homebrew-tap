class Nab < Formula
  desc "Ultra-minimal browser engine with HTTP/3, JS support, cookie auth, and anti-fingerprinting"
  homepage "https://github.com/MikkoParkkola/nab"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-aarch64-apple-darwin"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-x86_64-apple-darwin"
      sha256 "PLACEHOLDER_X64_SHA256"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-aarch64-unknown-linux-gnu"
      sha256 "PLACEHOLDER_LINUX_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-x86_64-unknown-linux-gnu"
      sha256 "PLACEHOLDER_LINUX_X64_SHA256"
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
