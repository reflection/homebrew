require 'formula'

class Noweb <Formula
  url 'ftp://www.eecs.harvard.edu/pub/nr/noweb.tgz'
  version '2.11b'
  homepage 'http://www.cs.tufts.edu/~nr/noweb/'
  md5 '1df580723497b2f2efde07646abf764c'

  depends_on 'icon'

  def install
    Dir.chdir "src" do
      system "make LIBSRC=icon ICONC=icont"

      kpse = `which kpsewhich`
      if kpse == ''
        ohai 'No TeX installation found. Installing TeX support files in the noweb Cellar.'
        texmf = "#{prefix}"
      else
        texmf = "`kpsewhich -var-value=TEXMFLOCAL`"
      end

      bin.mkpath
      lib.mkpath
      man.mkpath

      system "mkdir -p #{texmf}/tex/generic/noweb"
      system "make", "install", "BIN=#{bin}",
                                "LIB=#{lib}",
                                "MAN=#{man}",
                                "TEXINPUTS=#{texmf}/tex/generic/noweb"
    end
  end
end
