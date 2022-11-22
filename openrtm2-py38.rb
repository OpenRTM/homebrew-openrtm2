#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python3.8.
# To use this formula/bottle, switch python into python 3.8.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.8
#============================================================
class Openrtm2Py38 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "fe0ec792f2a4d4b3667abe6b2471bf844e49026ebe61b623da8309e011f8c206"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0"
    sha256 cellar: :any, big_sur: "6681f6468a8f204e065a1a960c44763d8b91f886199b7c6ba9072a9c35aadd65"
    sha256 cellar: :any, arm64_ventura: "e890c28093c3d647115434305fadb048cc86bf048c149b60b187235525dbc1fd"
  end

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py38"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
