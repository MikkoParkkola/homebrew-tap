class Nowifi < Formula
  desc "WiFi security assessment tool — 40 techniques for captive portals and WPA audits"
  homepage "https://github.com/MikkoParkkola/nowifi"
  version "0.9.0"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.9.0/nowifi-darwin-arm64.tar.gz"
      sha256 "8279709d54976beee3d9715ef4a738529bed6624758e80b61075fca96dd9cd3f"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.9.0/nowifi-darwin-amd64.tar.gz"
      sha256 "e3d2bcf55839b0e34d5f0e51e374e6ac2bd233c9cf063dd4826419f3adbd6719"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.9.0/nowifi-linux-arm64.tar.gz"
      sha256 "72d8479e9a2acb733634f79de4b20decbeba9a0208bd77d10e0a182581d586f2"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.9.0/nowifi-linux-amd64.tar.gz"
      sha256 "49bb744eae40bb3243d105cc07f22e176c42cef4d758ad86b38ee8c20f8e024f"
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
