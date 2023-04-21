#============================================================
# OpenRTP-aist cask for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#============================================================
cask "openrtp2" do
  arch arm: "aarch64", intel: "x86_64"

  version "2.0.1"
  sha256 "8c73bd59a4c958a1f018e8a966de9b861a434c9050ed42e8919be6f024e7b921"

  url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/openrtp2-en_v2.0.1.dmg",
      verified: "github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1/"
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
