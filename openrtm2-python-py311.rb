#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#
# This is the formula for OpenRTM-aist (Python) for python 3.11.
# To use this formula/bottle, switch python into python 3.11.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.11
#============================================================
class Openrtm2PythonPy311 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "83427e7da9169391d964c9de71a836089d6a475c79742d604353f0c6f43233c5"
  license "LGPL-2.1"

  bottle do
#    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
#    sha256 cellar: :any_skip_relocation, arm64_ventura: "eba03d164e8a9f853391d8022103bb11b8069adeeca33903a485761c7c5008cd"
#    sha256 cellar: :any_skip_relocation, monterey:      "5e8681a64342e122d1403c5796c5691e78342778746b3d4d9851668d054fb805"
  end

  depends_on "python@3.11"
  depends_on "openrtm/omniorb/omniorb-ssl-py311"
  depends_on "doxygen" => :build

  patch do
    url "https://raw.githubusercontent.com/OpenRTM/homebrew-openrtm2/refs/heads/main/Patch/setup.py.diff"
    sha256 "67c8a35cdac497f00e20f2fb4ca1d1ac138ffb6f1b3c6f75c4bea19f53f41a5a"
  end

  def install
    python3 = "#{Formula["python@3.11"].opt_bin}/python3.11"

    system python3, "-m", "pip", "install", "--break-system-packages", "build"
    system python3, "-m", "pip", "install", "--break-system-packages", "setuptools"
    system python3, "-m", "build"
    system python3, "-m", "pip",  "install",\
                    *std_pip_args(build_isolation: true),\
                    "dist/OpenRTM_aist_Python-2.0.2-py3-none-any.whl"

    # add executable permission to example scripts
    example_dir="#{prefix}/share/openrtm-2.0"
    Find.find(example_dir) do |path|
      if File.file?(path) && path.end_with?('.py')
        File.chmod(0755, path)
      end
      if File.file?(path) && path.end_with?('.sh')
        File.chmod(0755, path)
      end
    end
  end

  test do
    system "rtcprof_python3", "--help"
  end
end
