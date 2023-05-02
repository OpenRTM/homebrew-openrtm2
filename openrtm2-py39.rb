#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python3.9.
# To use this formula/bottle, switch python into python 3.9.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.9
#============================================================
class Openrtm2Py39 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "be38477abb8ba6c6095a1ed77bee93868eccbc7b2eea0ff12ef8a8f14a67ed02"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    sha256 cellar: :any, arm64_ventura: "03e78724077df336c7ad02e6c01bd1427ed9a878ba58d41b34f10f41141dd026"
    sha256 cellar: :any, monterey:      "b61999ff76fe6fa529e74e54c747cc6bcd8772af3ef8b9598b5b9aca7b2d5c97"
  end

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py39"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=${CMAKE_INSTALL_PREFIX}/lib"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
