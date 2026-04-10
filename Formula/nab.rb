class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.6.8/nab-aarch64-apple-darwin"
      sha256 "40b9bb66c08f1bc25eb6e9fa7352f8043659c436e69b8db41e5fa7eb3aa66270"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.6.8/nab-x86_64-apple-darwin"
      sha256 "e8041189b1923c1a19831171ebcf6480bff58c3e5c65a37630c28ac45b5a3cf7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.6.8/nab-aarch64-unknown-linux-gnu"
      sha256 "9e8a387b157164492c1f77c9b6d32c5551ed85e0fd6507fb53e41bed604fee8b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.6.8/nab-x86_64-unknown-linux-gnu"
      sha256 "e9b3c237b13f6d437b5d70c07eb22991bb2b0415227272f7db80ea141af00b36"
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
