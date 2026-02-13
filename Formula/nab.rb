class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-aarch64-apple-darwin"
      sha256 "PLACEHOLDER_AARCH64_DARWIN"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-x86_64-apple-darwin"
      sha256 "PLACEHOLDER_X86_64_DARWIN"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-aarch64-unknown-linux-gnu"
      sha256 "PLACEHOLDER_AARCH64_LINUX"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.4.0/nab-x86_64-unknown-linux-gnu"
      sha256 "PLACEHOLDER_X86_64_LINUX"
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
