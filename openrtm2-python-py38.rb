#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#============================================================
class Openrtm2PythonPy38 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "983e13f8dc6239038405e778fc51d0758270778d0f3ea8595fb9b2f13590d236"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c22f24e9fa7a8282cc5eb33b85009165ec45bc37ce0a05bfc73722d154cb10d7"
    sha256 cellar: :any_skip_relocation, monterey:      "5cc4b054bffee2d19740fc57756e0438c2a43c3b4b9ccdf7003be07a047be563"
  end

  depends_on "openrtm/omniorb/omniorb-ssl-py38"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.8"].opt_bin}/python3.8"
    example_dir = "#{prefix}/share/openrtm-2.0/components/python3/"
    system python3, "setup.py", "build"
    system python3, "setup.py", "install", "--prefix=#{prefix}"

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
