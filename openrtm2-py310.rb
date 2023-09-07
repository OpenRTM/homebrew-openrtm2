#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python 3.10.
# To use this formula/bottle, switch python into python 3.10.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.10
#============================================================
class Openrtm2Py310 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "ebb15105f4400dd70e603c471feb207eef6cf3396f1f30a70601c96329cb1ecf"
  license "LGPL-2.1"

  bottle do
#    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    rebuild 1
    sha256 cellar: :any, arm64_ventura: "006ec2d5f0de496992daf4628fbd7f896ad8969334e62028a27d84ad14a6d444"
    rebuild 1
    sha256 cellar: :any, arm64_squoia: "006ec2d5f0de496992daf4628fbd7f896ad8969334e62028a27d84ad14a6d444"
    rebuild 1
    sha256 cellar: :any, arm64_sonoma: "006ec2d5f0de496992daf4628fbd7f896ad8969334e62028a27d84ad14a6d444"
    rebuild 1
    sha256 cellar: :any, ventura: "7a2be702ffedc9553f14bb061e76836465d8b94778de4705a30402aa1e43f216"
  end


  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py310"

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
