#============================================================
# OpenRTP-aist cask for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#============================================================
cask "openrtp2" do
  arch arm: "aarch64", intel: "x86_64"

  version "2.0.1"
  sha256 "bcfddecb356952427e59196b44d4a54806361abf6c54c4882a30beebe11738a3"

  url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/openrtp2-en_v2.0.1.dmg",
      verified: "github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/"
  name "OpenRTP2"
  desc "Open RT Platform tool chain ver 2.0"
  homepage "https://openrtm.org/"

  app "OpenRTP2-en.app"

  preflight do
    system_command "chflags",
                   args: ["nohidden", "#{staged_path}/OpenRTP2-en.app"]
    system_command "xattr",
                   args: ["-cr", "#{staged_path}/OpenRTP2-en.app"]
  end

  caveats do
    depends_on_java "8"
  end
end
