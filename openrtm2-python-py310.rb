#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy310 < Formula
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

  depends_on "openrtm/omniorb/omniorb-ssl-py310"
  depends_on "doxygen" => :build

  patch do
    url "https://raw.githubusercontent.com/OpenRTM/homebrew-openrtm2/refs/heads/main/Patch/pyproject.toml.diff"
    sha256 "ac2be060ff675603be2665ccc9e490ff14525799b8a5d8f185358324877e9710"
  end
  patch do
    url "https://raw.githubusercontent.com/OpenRTM/homebrew-openrtm2/refs/heads/main/Patch/setup.py.diff"
    sha256 "bab4793ba437663cb43d2ae50b2bc9f56409296883bee6b6319efe80dc6ba708"
  end

  def install
    python3 = "#{Formula["python@3.10"].opt_bin}/python3.10"
    homebrew_prefix = ENV["HOMEBREW_PREFIX"]
#    system python3, "setup.py", "build"
    # system python3, "setup.py", "install", "--prefix=#{prefix}]"

    # setup.py's prefix option does not work in 3.10 or later 
#    system "mkdir", "TMP"
    system python3, "-m", "pip", "install", "--break-system-packages", "build"
    system python3, "-m", "pip", "install", "--break-system-packages", "setuptools"
    system python3, "-m", "build"
    example_dir="OpenRTM_aist/examples/"
    Find.find(example_dir) do |path|
      if File.file?(path) && path.end_with?('.py')
        File.chmod(0755, path)
      end
      if File.file?(path) && path.end_with?('.sh')
        File.chmod(0755, path)
      end
    end
    system python3, "-m", "pip",  "install",\
                    *std_pip_args(build_isolation: true),\
                    "dist/OpenRTM_aist_Python-2.0.2-py3-none-any.whl"
#    system python3, "-m", "pip",  "install", "--no-index",\
#                    "--prefix=#{homebrew_prefix}",\
#                    "dist/OpenRTM_aist_Python-2.0.2-py3-none-any.whl"
#    system "whoami"
#    example_dir="TMP/#{homebrew_prefix}/share/"
#    Find.find(example_dir) do |path|
#      if File.file?(path) && path.end_with?('.py')
#        File.chmod(0755, path)
#      end
#      if File.file?(path) && path.end_with?('.sh')
#        File.chmod(0755, path)
#      end
#    end
#    
#    # Installing target directories
#    bin.install   Dir["TMP/#{homebrew_prefix}/bin/*"]
#    share.install Dir["TMP/#{homebrew_prefix}/share/*"]
#    lib.install   Dir["TMP/#{homebrew_prefix}/lib/*"]
  end

  test do
    system "rtcprof_python3", "--help"
  end
end
