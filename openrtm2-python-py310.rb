#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy310 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "3e2fc7c505fa29b1cf1915f90837291e9bbc1514bad4e1a730bd408c0abb15c6"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f43fe34c91d015a3f7da7fe9b96a801f87ae33839b1d45c66b4cc19ebe58086a"
    sha256 cellar: :any_skip_relocation, big_sur: "442ef00e26c02c6d6035c65294e8d97514fb105cbd4ed55ccc79c4b8daa5bb9e"
  end

  depends_on "openrtm/omniorb/omniorb-ssl-py310"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.10"].opt_bin}/python3.10"
    system python3, "setup.py", "build"
    # system python3, "setup.py", "install", "--prefix=#{prefix}]"

    # setup.py's prefix option does not work in 3.9 or later 
    system "mkdir", "TMP"
    system python3, "setup.py", "install", "--root=./TMP/"
    bin.install   Dir["TMP/opt/homebrew/bin/*"]
    share.install Dir["TMP/opt/homebrew/share/*"]
    lib.install   Dir["TMP/opt/homebrew/lib/*"]
  end

  test do
    system "rtcprof_python3", "--help"
  end
end
