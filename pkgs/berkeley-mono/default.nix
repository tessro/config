# Berkeley Mono — a commercial monospaced typeface from U.S. Graphics Company.
#
# The font files are licensed and may not be redistributed, so they live in the
# private `config-private` repo (under fonts/) rather than this public one. The
# caller passes that directory in as `src`; see modules/fonts.nix.
{
  lib,
  stdenvNoCC,
  src,
}:

stdenvNoCC.mkDerivation {
  pname = "berkeley-mono";
  version = "2.004";

  inherit src;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 -t "$out/share/fonts/opentype" $src/BerkeleyMono-*.otf
    runHook postInstall
  '';

  meta = {
    description = "Berkeley Mono — monospaced typeface from U.S. Graphics Company";
    homepage = "https://usgraphics.com/products/berkeley-mono";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
  };
}
