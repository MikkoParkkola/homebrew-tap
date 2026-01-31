class Microfetch < Formula
  desc "Ultra-minimal browser engine with HTTP/3, JS support, cookie auth, and anti-fingerprinting"
  homepage "https://github.com/MikkoParkkola/microfetch"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/microfetch/releases/download/v0.2.0/microfetch-aarch64-apple-darwin"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/microfetch/releases/download/v0.2.0/microfetch-x86_64-apple-darwin"
      sha256 "PLACEHOLDER_X64_SHA256"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/microfetch/releases/download/v0.2.0/microfetch-aarch64-unknown-linux-gnu"
      sha256 "PLACEHOLDER_LINUX_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/microfetch/releases/download/v0.2.0/microfetch-x86_64-unknown-linux-gnu"
      sha256 "PLACEHOLDER_LINUX_X64_SHA256"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "microfetch-aarch64-apple-darwin" => "microfetch"
      else
        bin.install "microfetch-x86_64-apple-darwin" => "microfetch"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "microfetch-aarch64-unknown-linux-gnu" => "microfetch"
      else
        bin.install "microfetch-x86_64-unknown-linux-gnu" => "microfetch"
      end
    end
  end

  test do
    assert_match "microfetch", shell_output("#{bin}/microfetch --version")
  end
end
