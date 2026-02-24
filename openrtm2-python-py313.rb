#============================================================
# OpenRTM-aist-Python formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm2
#
# This is the formula for OpenRTM-aist (Python) for python 3.13.
# To use this formula/bottle, switch python into python 3.13.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.13
#============================================================
class Openrtm2PythonPy313 < Formula
  desc "OpenRTM-aist: RT-Middleware and OMG RTC implementation in Python implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist-Python/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "d07942eed317e96cd5a2da440464cd209bae4356a528d06dbcfbaa26473040c4"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.1.0"
  end

  depends_on "python@3.13"
  depends_on "openrtm/omniorb/omniorb-ssl-py313"
  depends_on "doxygen" => :build

  def install
    python3 = "#{Formula["python@3.13"].opt_bin}/python3.13"

    system python3, "-m", "pip", "install", "--break-system-packages", "build"
    system python3, "-m", "pip", "install", "--break-system-packages", "setuptools"
    system python3, "-m", "build"
    system python3, "-m", "pip",  "install",\
                    *std_pip_args(build_isolation: true),\
                    "dist/openrtm_aist_python-2.1.0-py3-none-any.whl"

    # copy examples to share_dir
    src_examples = HOMEBREW_PREFIX/"lib/python3.13/site-packages/OpenRTM_aist/examples"
    dst_examples = prefix/"share/openrtm-2.1/components/python3"

    mkdir_p dst_examples
    cp_r src_examples, dst_examples

    # add executable permission to example scripts
    example_dir="#{prefix}/share/openrtm-2.1"
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
