#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python 3.13.
# To use this formula/bottle, switch python into python 3.13.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.13
#============================================================
class Openrtm2Py313 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "3462bb01dacf69b058706e636cafd817e3abe97631b3056d0fa9d38f2e43fe6e"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.1.0"
    rebuild 1
    sha256 cellar: :any, arm64_sequoia: "ace0df3be962fd6c3c7644ff6d490b61b641e5504c57b1da9405683a73f18daa"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe: "9a5ad846c3161af3f172a16d19a05e27bc3e33b78e063a351f5a009a2d4825ca"
  end




  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py313"


  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=${CMAKE_INSTALL_PREFIX}/lib"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
