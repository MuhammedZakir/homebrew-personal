# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Wget2 < Formula
  desc "GNU Wget2 is the successor of GNU Wget, a file and recursive website downloader."
  homepage "https://gitlab.com/gnuwget/wget2"
  url "https://ftp.gnu.org/gnu/wget/wget2-1.99.2.tar.gz"
  head "https://gitlab.com/gnuwget/wget2.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "make" => :build
  depends_on "libtool" => :build
  depends_on "gettext" 
  depends_on "python3" => :build
  depends_on "doxygen" => :build
  depends_on "pandoc" => :build
  depends_on "bzip2" => :optional
  depends_on "xz"
  depends_on "lzip" => :head
  depends_on "bzip2" => :optional
  depends_on "brotli" => :optional
  depends_on "zstd" => :optional
  depends_on "openssl@1.1"
  depends_on "gnutls" => :optional
  depends_on "libidn2"
  depends_on "flex"
  depends_on "libpsl"
  depends_on "nghttp2" => :optional
  depends_on "pcre" => :optional
  depends_on "pcre2" => :optional
  depends_on "hsts" => :optional
  depends_on "wolfssl" => :optional

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    args = %W[
      --prefix=#{prefix}
      --mandir=#{man}
      --sysconfdir=#{etc}
      --with-ssl=openssl
      --without-libhsts
      --without-gpgme
      --without-libmicrohttpd
    ]
    system "./bootstrap", "--skip-po" if build.head?
    system "./configure", *args
#    system "make"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test wget2`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system bin/"wget", "-O", "/dev/null", "https://example.com"
  end
end
