#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy38 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "3e2fc7c505fa29b1cf1915f90837291e9bbc1514bad4e1a730bd408c0abb15c6"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.0"
    sha256 cellar: :any_skip_relocation, big_sur: "442ef00e26c02c6d6035c65294e8d97514fb105cbd4ed55ccc79c4b8daa5bb9e"
  end

  depends_on "openrtm/omniorb/omniorbpy-py38"
  depends_on "doxygen" => :build

  def install
    comp_dir = "#{prefix}/share/openrtm-2.0/components/python3/"
    system "/usr/local/opt/python@3.8/bin/python3.8", "setup.py", "build"
    system "/usr/local/opt/python@3.8/bin/python3.8", "setup.py", "install", "--prefix=#{prefix}"
    FileUtils.chmod_R(0755, comp_dir.to_s)
  end

  test do
    system "rtcprof_python3", "--help"
  end
end
