class Nowifi < Formula
  desc "WiFi security assessment tool — 43 techniques for captive portals and WPA audits"
  homepage "https://github.com/MikkoParkkola/nowifi"
  version "0.14.1"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.1/nowifi-darwin-arm64.tar.gz"
      sha256 "1e1b344686b67501704dcbd03c2a3e85de0f7addf477a9c59d20ed109bdef1c1"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.1/nowifi-darwin-amd64.tar.gz"
      sha256 "2e3b6a084f82112829440cc69f9f16df5edb67b0c7a6fa17d0c25a729cc12e15"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.1/nowifi-linux-arm64.tar.gz"
      sha256 "f446bf58c85170c4c1a3da6dc8b267b35353bdc1bae18189abd4ee024a3b5822"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.1/nowifi-linux-amd64.tar.gz"
      sha256 "da73be77ca954a414dd0fd87dbe9a0980e97e67e4df8abeb7b18748366281dca"
    end
  end

  def install
    # Each tarball contains a single bare binary named nowifi-<os>-<arch>.
    # Pick whatever is in the staging dir and install it as bin/nowifi.
    binary = Dir["nowifi-*"].first
    odie "no nowifi binary in tarball" unless binary
    bin.install binary => "nowifi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"nowifi"} --version")
  end
end
