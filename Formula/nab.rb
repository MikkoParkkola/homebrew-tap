class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.7.2/nab-aarch64-apple-darwin"
      sha256 "0170acc6d6cdefa48fe3329f05298aa3e132456350300bd9e8f6f80e853f7fc3"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.7.2/nab-x86_64-apple-darwin"
      sha256 "6e0bea0a3d98d541a9071869a2132e1cc7a01c3012ee0357cff1c5f3dea82739"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.7.2/nab-aarch64-unknown-linux-gnu"
      sha256 "3621de5cda7a2be577466bf8063a2c2ccaa4a5dc4b8ff402f3daaed7b1da37bc"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.7.2/nab-x86_64-unknown-linux-gnu"
      sha256 "bcc3d891ab398c785c812578fb4936676495fbc93879a4db1a6a0b8ca1382e55"
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
