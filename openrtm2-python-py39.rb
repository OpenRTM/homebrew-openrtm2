#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy39 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "83427e7da9169391d964c9de71a836089d6a475c79742d604353f0c6f43233c5"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "eba03d164e8a9f853391d8022103bb11b8069adeeca33903a485761c7c5008cd"
    sha256 cellar: :any_skip_relocation, monterey:      "5e8681a64342e122d1403c5796c5691e78342778746b3d4d9851668d054fb805"
  end

  depends_on "openrtm/omniorb/omniorb-ssl-py39"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.9"].opt_bin}/python3.9"
    homebrew_prefix = ENV["HOMEBREW_PREFIX"]
    system python3, "setup.py", "build"
    # system python3, "setup.py", "install", "--prefix=#{prefix}]"

    # setup.py's prefix option does not work in 3.9 or later 
    system "mkdir", "TMP"
    system python3, "setup.py", "install", "--root=./TMP/"
    example_dir="TMP/#{homebrew_prefix}/share/"
    Find.find(example_dir) do |path|
      if File.file?(path) && path.end_with?('.py')
        File.chmod(0755, path)
      end
      if File.file?(path) && path.end_with?('.sh')
        File.chmod(0755, path)
      end
    end
    
    # Installing target directories
    bin.install   Dir["TMP/#{homebrew_prefix}/bin/*"]
    share.install Dir["TMP/#{homebrew_prefix}/share/*"]
    lib.install   Dir["TMP/#{homebrew_prefix}/lib/*"]
  end

  test do
    system "rtcprof_python3", "--help"
  end
end
