#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy311 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "3e2fc7c505fa29b1cf1915f90837291e9bbc1514bad4e1a730bd408c0abb15c6"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "62aa4f92492aa889b186d612a21b1642ef06c7308fb7882c683f331f736962c0"
    sha256 cellar: :any_skip_relocation, monterey: "f51082cd9a78a83d7c11d191cc5cf0bbca449fb2ad4b73e8fddef65478df56b3"
  end

  depends_on "openrtm/omniorb/omniorb-ssl-py311"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.11"].opt_bin}/python3.11"
    homebrew_prefix = ENV["HOMEBREW_PREFIX"]
    system python3, "setup.py", "build"
    # system python3, "setup.py", "install", "--prefix=#{prefix}]"

    # setup.py's prefix option does not work in 3.9 or later 
    system "mkdir", "TMP"
    system python3, "setup.py", "install", "--root=./TMP/"
    bin.install   Dir["TMP/#{homebrew_prefix}/bin/*"]
    share.install Dir["TMP/#{homebrew_prefix}/share/*"]
    lib.install   Dir["TMP/#{homebrew_prefix}/lib/*"]
  end

  test do
    system "rtcprof_python3", "--help"
  end
end
