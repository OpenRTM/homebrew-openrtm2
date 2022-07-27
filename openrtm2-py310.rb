#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python3.10.
# To use this formula/bottle, switch python into python 3.10.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.10
#============================================================
class Openrtm2Py310 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "fe0ec792f2a4d4b3667abe6b2471bf844e49026ebe61b623da8309e011f8c206"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0"
    sha256 cellar: :any, big_sur: "69f6648e7b48bfc6eaff2a7f0fbe08c5693f9ed7d4b558d25ce911054f0573e8"
  end

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py310"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end