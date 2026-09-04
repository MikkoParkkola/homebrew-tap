class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.3/nab-aarch64-apple-darwin"
      sha256 "68de02c6c306977d93f818ece8cadb5ac63f0158a2856c26d053d00bacbc2e51"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.3/nab-x86_64-apple-darwin"
      sha256 "6f3b584b89c70ec2f5b8f93cdecbb2962de4e248b3a23d37a55595e47c707334"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.3/nab-aarch64-unknown-linux-gnu"
      sha256 "5cd5e6b10e3d1bab999bcf0b7a8e0a292831316e22a55fcb2d1ea356f97288d4"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.3/nab-x86_64-unknown-linux-gnu"
      sha256 "4552fbf1166aa38ee5701d67c2107586734bbe75e8dea8dbb1a99aea65fe9761"
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
