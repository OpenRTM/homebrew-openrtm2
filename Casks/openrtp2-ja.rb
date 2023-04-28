#============================================================
# OpenRTP-aist cask for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#============================================================
cask "openrtp2-ja" do
  arch arm: "aarch64", intel: "x86_64"

  version "2.0.1"
  sha256 "c01bee34a620441cb3f5828cf2ba86623a04a035127a58019b0743e265f0c316"
  
  url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/openrtp2-ja_v2.0.1.dmg",
      verified: "github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/"
  name "OpenRTP2"
  desc "Open RT Platform tool chain ver 2.0 (Japanese)"
  homepage "https://openrtm.org/"

  app "OpenRTP2-ja.app"

  preflight do
    system_command "chflags",
                   args: ["nohidden", "#{staged_path}/OpenRTP2-ja.app"]
    system_command "xattr",
                   args: ["-cr", "#{staged_path}/OpenRTP2-ja.app"]
  end

  caveats do
    depends_on_java "8"
  end
end
