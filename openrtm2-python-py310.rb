#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#
# This is the formula for OpenRTM-aist (Python) for python 3.10.
# To use this formula/bottle, switch python into python 3.10.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.10
#============================================================
class Openrtm2PythonPy310 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "83427e7da9169391d964c9de71a836089d6a475c79742d604353f0c6f43233c5"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura: "b88439bb5af54727f2913bfe7984242c4d9401634b29ba6ee5f68a80549ee35e"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "806e036f194ad8b59af36e6947d7f9f99abaabddd15f1a2cda5175bbc80b5d38"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura: "806e036f194ad8b59af36e6947d7f9f99abaabddd15f1a2cda5175bbc80b5d38"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "806e036f194ad8b59af36e6947d7f9f99abaabddd15f1a2cda5175bbc80b5d38"
  end



  depends_on "python@3.10"
  depends_on "openrtm/omniorb/omniorb-ssl-py310"
  depends_on "doxygen" => :build

  patch do
    url "https://raw.githubusercontent.com/OpenRTM/homebrew-openrtm2/refs/heads/main/Patch/setup.py.diff"
    sha256 "67c8a35cdac497f00e20f2fb4ca1d1ac138ffb6f1b3c6f75c4bea19f53f41a5a"
  end

  def install
    python3 = "#{Formula["python@3.10"].opt_bin}/python3.10"

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
