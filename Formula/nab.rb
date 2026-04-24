class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  version "0.8.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.4/nab-aarch64-apple-darwin"
      sha256 "bd3f5e548abe4782d5d41fd999b5b2eddc98c0e710772940e2120106bf539cc4"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.4/nab-x86_64-apple-darwin"
      sha256 "107ae1ca0c0d530df23a81ae595d6652cc29c4210e0103f13e20e0a7e1166348"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.4/nab-aarch64-unknown-linux-gnu"
      sha256 "d85a2d129b40a754f2a248fe819a4edbbf8f81a1c8af95030fb8c00964ab26ab"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.4/nab-x86_64-unknown-linux-gnu"
      sha256 "1b747547b932b6169a9fa14bbb241c200633069738a081378c0386194f295846"
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
