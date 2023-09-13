#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python 3.12.
# To use this formula/bottle, switch python into python 3.12.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.12
#============================================================
class Openrtm2Py312 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "ebb15105f4400dd70e603c471feb207eef6cf3396f1f30a70601c96329cb1ecf"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.2"
    rebuild 1
    sha256 cellar: :any, arm64_sonoma: "fb05c79182e7ce46aff6f747de281e8ddc1c68c127a71a584f4a144a86e49060"
    rebuild 1
    sha256 cellar: :any, arm64_ventura: "fb05c79182e7ce46aff6f747de281e8ddc1c68c127a71a584f4a144a86e49060"
    rebuild 1
    sha256 cellar: :any, arm64_squoia: "fb05c79182e7ce46aff6f747de281e8ddc1c68c127a71a584f4a144a86e49060"
    rebuild 1
    sha256 cellar: :any, ventura: "f339d0a2bcc12829fcda3fb350854445fdac768cc11bc5c2ef110b5551a679dd"
  end


  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py312"

  patch do
    url "https://raw.githubusercontent.com/OpenRTM/homebrew-openrtm2/refs/heads/main/Patch/CMakeList.txt.diff"
    sha256 "d0dcd886155ae4f613c5ab10344e4a38486da8caee2e129fff0c54cdf8d8b7da"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=${CMAKE_INSTALL_PREFIX}/lib"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
