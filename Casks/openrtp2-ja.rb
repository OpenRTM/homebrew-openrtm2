#============================================================
# OpenRTP-aist cask for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#============================================================
cask "openrtp2-ja" do
  arch arm: "aarch64", intel: "x86_64"

  version "2.0.0"
  sha256 "8145aa52aa4c1949aed2917f1f93f8e48868b56a94b013b3b18b544fcfca4297"
  
  url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/openrtp2-ja_v2.0.1.dmg",
      verified: "github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/"
  name "OpenRTP2"
  desc "Open RT Platform tool chain ver 2.0 (Japanese)"
  homepage "https://openrtm.org/"

  depends_on cask: "homebrew/cask-versions/adoptopenjdk8"

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
