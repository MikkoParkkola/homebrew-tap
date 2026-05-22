class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.10.3/nab-aarch64-apple-darwin"
      sha256 "ca1d713a7e7d590af859b1000f7bf9b1958a951d553538d3c4166eb48f2f2ff7"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.10.3/nab-x86_64-apple-darwin"
      sha256 "b120e2f8e97933b55417446d442d9a8a61beb9c523fee5b0b2937dc0c569888c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.10.3/nab-aarch64-unknown-linux-gnu"
      sha256 "3bd4c7d061ef174fcc0d09caa3e81e24c82a19aca99b896a7b8cb9a79bfe15ab"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.10.3/nab-x86_64-unknown-linux-gnu"
      sha256 "bfc296f61300c2db156abe4daedda7cca49f27460b4de18cf688724154ad9b16"
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
