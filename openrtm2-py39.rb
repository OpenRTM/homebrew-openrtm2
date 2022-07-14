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
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "fe0ec792f2a4d4b3667abe6b2471bf844e49026ebe61b623da8309e011f8c206"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0"
    sha256 cellar: :any, big_sur: "e99ed2036afb54ec6d3026b198bcc1761c813c7b0bb26e7c6c7a30c22a1ab487"
  end

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py39"

#  patch do
#    url "https://raw.githubusercontent.com/OpenRTM/homebrew-openrtm/master/Patches/rtm-naming.diff"
#    sha256 "a41cbb5d166728ac666860e6354f7269b92c04b58c4235141080b2020be3aaca"
#  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
