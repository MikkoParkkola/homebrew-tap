class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  version "0.8.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.5/nab-aarch64-apple-darwin"
      sha256 "7db8fac2a7d049eea41824322308634612f5cfdbbf83b6f341d31f3834bad54a"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.5/nab-x86_64-apple-darwin"
      sha256 "48897d6e56090d561550f26585f8e4819f2899c05caaed99872d9e270fa9200b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.5/nab-aarch64-unknown-linux-gnu"
      sha256 "b18882b95b938fe73714a93ef9cdca9f7f025fc71b18cfa47dfc0b87fd501879"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.8.5/nab-x86_64-unknown-linux-gnu"
      sha256 "f0a590286e1a2fbc4b5be66dd3468d40f52f115543d179e797f2d3dfa1fbb48e"
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
