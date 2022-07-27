#============================================================
# OpenRTP-aist cask for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#============================================================
cask "openrtp2-jp" do
  version "2.0.0"
  sha256 "e84cdf01dd7186855e2be504f50a95b7d31cb48ec8182fd6d85220f0dd2923fa"
  
  url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0/openrtp2-jp_v2.0.0.dmg"
  name "OpenRTP2"
  desc "Open RT Platform tool chain ver 2.0 (Japanese)"
  homepage "https://openrtm.org/"

  depends_on cask: "homebrew/cask-versions/adoptopenjdk8"

  app "OpenRTP2.app"

  caveats do
    depends_on_java "8"
  end
end
