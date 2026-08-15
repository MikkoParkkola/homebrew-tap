class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.2/nab-aarch64-apple-darwin"
      sha256 "40ab7be2a6394fa0c5b825bf1ab2ef6a747e2beab74d72c7abee8174a4582543"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.2/nab-x86_64-apple-darwin"
      sha256 "c5630f2293f35e1747a434dcd7d6606673fa86915e7e1f3b6352231e3801c373"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.2/nab-aarch64-unknown-linux-gnu"
      sha256 "fd19e2d0269eb01e4d0a8a0b221da0a1f49a8966b1063dabce0da1ff78fac603"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.2/nab-x86_64-unknown-linux-gnu"
      sha256 "2091eb7c93fb8a8852b8afc96f0bfe6e01599090fe9bb4de88e1b0537866ee66"
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
