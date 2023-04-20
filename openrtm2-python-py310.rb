#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy310 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "983e13f8dc6239038405e778fc51d0758270778d0f3ea8595fb9b2f13590d236"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "17a98a7bada4da6b82c23eb482e3f6e8d6fab0853bf13d98d4e737f3a00fc01f"
    sha256 cellar: :any_skip_relocation, monterey: "e6a70001a730bc0781c3ac0ef8db7440e047b6939e14efa91933cbba7cbd3643"
  end

  depends_on "openrtm/omniorb/omniorb-ssl-py310"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.10"].opt_bin}/python3.10"
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
