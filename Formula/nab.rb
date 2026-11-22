class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.3/nab-aarch64-apple-darwin"
      sha256 "12f0a7f9ebbe593ca857298a80476d3a0639ae8dc17a148025f23316314d2855"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.3/nab-x86_64-apple-darwin"
      sha256 "7333ca979bac57f7fb0ca338e3db372c3b0264b630d609f254b433368456b2ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.3/nab-aarch64-unknown-linux-gnu"
      sha256 "a180d8d42fbc216fb498bbb4187d2a5a6274b4134b5631a0d57c35eeb288c223"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.3/nab-x86_64-unknown-linux-gnu"
      sha256 "b1b0669ad61e45814b8bb96195f1e97c7797a33c1337dddaa734681dc907117a"
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
