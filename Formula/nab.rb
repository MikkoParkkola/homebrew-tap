class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.1/nab-aarch64-apple-darwin"
      sha256 "7b2a35e2c1cce321f5f021dff254bda467619e867d6f87d9c223264eaa2da072"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.1/nab-x86_64-apple-darwin"
      sha256 "5899acacf4325fb1045ec3967d01aa6b6ed9b2445d3d2d9d9a41512af0a26118"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.1/nab-aarch64-unknown-linux-gnu"
      sha256 "f4424a1abd8f69a41c1816cd03c6bbf138ad9dfe13335170bb9bef2f67e0e0d7"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.1/nab-x86_64-unknown-linux-gnu"
      sha256 "d72a49655736c57b4ed601f5fe424e3f635e2fe0a7b7d0ebb2c814dae580d951"
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
