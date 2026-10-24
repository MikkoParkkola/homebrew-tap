class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.6/nab-aarch64-apple-darwin"
      sha256 "e9d6e632e61b9cee7eb2e88112dffb6a706bca75135326251f63dc67ee74b1e8"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.6/nab-x86_64-apple-darwin"
      sha256 "9d61cca5a9c2d4236bf0ff659d7b90b46c7c5555ae9f34d5f0cb2ef0e0e3bd41"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.6/nab-aarch64-unknown-linux-gnu"
      sha256 "04060078e37bcf670d80934ad5a4987b2557bf0aa6cca6902ccbaad98ce7c218"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.6/nab-x86_64-unknown-linux-gnu"
      sha256 "044a254b0754cc157b748d4a2c11d1658f19e8a2442502171b34ee95f74cda2f"
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
