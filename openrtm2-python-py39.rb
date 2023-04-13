#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy39 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "983e13f8dc6239038405e778fc51d0758270778d0f3ea8595fb9b2f13590d236"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b391c584e00dee29853d9ef063eff272d7ed33761fa3fd3631052136ba0158d6"
    sha256 cellar: :any_skip_relocation, monterey: "34823d978e3a6b9ae07fb0de4ccea2cb346d2a8e6a85b3db107f7f836cc5b396"
  end

  depends_on "openrtm/omniorb/omniorb-ssl-py39"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.9"].opt_bin}/python3.9"
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
