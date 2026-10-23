class Nab < Formula
  desc "Token-optimized HTTP client for LLMs — fetches any URL as clean markdown"
  homepage "https://github.com/MikkoParkkola/nab"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.5/nab-aarch64-apple-darwin"
      sha256 "2171d6e59a5a003c09abd0a244daf6b56b7d8077244ec0146520bc74c5384f15"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.5/nab-x86_64-apple-darwin"
      sha256 "60c4c30487938944d6a335f5a24cb71ec4a2e983f712d1bb28938575b56091a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.5/nab-aarch64-unknown-linux-gnu"
      sha256 "19a160fd454d47c30d05d5f78ef9030c7593ff8575594b3e8704b192bd3e8b97"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nab/releases/download/v0.12.5/nab-x86_64-unknown-linux-gnu"
      sha256 "3621ab75c02956235910e10786cb7daf079a7c34ecf0ddb9a8491544a4c972e5"
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
