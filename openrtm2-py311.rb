#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python3.11.
# To use this formula/bottle, switch python into python 3.11.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.11
#============================================================
class Openrtm2Py311 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "be38477abb8ba6c6095a1ed77bee93868eccbc7b2eea0ff12ef8a8f14a67ed02"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    sha256 cellar: :any, arm64_ventura: "02fcabdcd8c926a63c9469a6e99a6465b4a03037c87086cc2e0cd887c12347ee"
    sha256 cellar: :any, monterey:      "7ac751adc161a62b36c6ef9821eeed4247395f7441256832857243e9a8e5b6e8"
  end

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py311"

  def install
    homebrew_prefix = ENV["HOMEBREW_PREFIX"]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=${CMAKE_INSTALL_PREFIX}/lib"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
