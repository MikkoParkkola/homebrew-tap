class Nab < Formula
  desc "Ultra-minimal browser engine with HTTP/3, JS support, cookie auth, and anti-fingerprinting"
  homepage "https://github.com/MikkoParkkola/nab"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-aarch64-apple-darwin"
      sha256 "6de14f379d6231b2c333f3b83d4a4c86703e453d28cf38f3bcac7fb70080ca6c"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-x86_64-apple-darwin"
      sha256 "3ad10dc7ba0931ec24299c59c8d1b249577b0143b95f67b520b8ac129b3f26b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-aarch64-unknown-linux-gnu"
      sha256 "e26616d41dbd694416dcfef4e40a5c8ff8fd4f62eb030172476beba365c05be8"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.3.0/nab-x86_64-unknown-linux-gnu"
      sha256 "78e97ad5c33678077853329bab84542dc2e97fec67750461bbe2aadf5cc70797"
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
