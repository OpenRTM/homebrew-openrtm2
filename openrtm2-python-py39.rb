#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy39 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "3e2fc7c505fa29b1cf1915f90837291e9bbc1514bad4e1a730bd408c0abb15c6"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "267ad1c609c49a9f08bcb55610897ac2c5beff568b09f90145af92c0adddc3ee"
    sha256 cellar: :any_skip_relocation, big_sur: "39bc0194b551f77064105999229b6ce0c880ac06c0b536b92137a6c317527ba9"
  end

  depends_on "openrtm/omniorb/omniorb-ssl-py39"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.9"].opt_bin}/python3.9"
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
