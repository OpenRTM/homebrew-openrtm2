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
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "be38477abb8ba6c6095a1ed77bee93868eccbc7b2eea0ff12ef8a8f14a67ed02"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    sha256 cellar: :any, arm64_ventura: "b7037f7aa726b1c10fe71f43b4d23aa5d667fc535d01cf6e0e9e0067e555ed54"
    sha256 cellar: :any, monterey:      "a7b22c83b71ae00a7dfbef1951e8c613390bf499ca8e4ee3f5d2881b827a98ab"
  end

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py310"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=${CMAKE_INSTALL_PREFIX}/lib"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
