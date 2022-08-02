#============================================================
# OpenRTP-aist cask for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#============================================================
cask "openrtp2" do
  arch arm: "aarch64", intel: "x86_64"

  version "2.0.0"
  sha256 "c834695e59c8abd355799c041f6ce6c8a14451114a0b264b2ca76dd06de2e4fc"

  url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0/openrtp2-en_v2.0.0.dmg",
      verified: "github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0/"
  name "OpenRTP2"
  desc "Open RT Platform tool chain ver 2.0"
  homepage "https://openrtm.org/"

  depends_on cask: "homebrew/cask-versions/adoptopenjdk8"

  app "OpenRTP2.app"

  caveats do
    depends_on_java "8"
  end
end
