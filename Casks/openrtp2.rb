#============================================================
# OpenRTP-aist cask for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#============================================================
cask "openrtp2" do
  arch arm: "aarch64", intel: "x86_64"

  version "2.0.0"
  sha256 "4af95d1082ad22bb31ad78705761b014d4e2258bb6a66016e72febfa2b487d10"

  url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0/openrtp2-en_v2.0.0.dmg",
      verified: "github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0/"
  name "OpenRTP2"
  desc "Open RT Platform tool chain ver 2.0"
  homepage "https://openrtm.org/"

  depends_on cask: "homebrew/cask-versions/adoptopenjdk8"

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
