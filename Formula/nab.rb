class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.0/nab-aarch64-apple-darwin"
      sha256 "fc41e70f1d74e8afa7a0d64c173fd4655b72a8b3a71d352df79e575e791450ab"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.0/nab-x86_64-apple-darwin"
      sha256 "172ca00a7745d16a497dcc14f9c058221f55df2f59675b5d234751794aac49ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.0/nab-aarch64-unknown-linux-gnu"
      sha256 "db1021ec0760ef746af73037b7689d4c8a8c7cf6ee77c2fe648e9a96710d73d0"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.13.0/nab-x86_64-unknown-linux-gnu"
      sha256 "5e7f02a799aeb4b7a245463ce36f5e97e88e8c14059e7c8200062f82d8bdb43f"
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
