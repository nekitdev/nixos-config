{
  autoPatchelfHook,
  dpkg,
  e2fsprogs,
  fetchurl,
  fontconfig,
  freetype,
  lib,
  libGL,
  libffi,
  libgpg-error,
  openssl,
  qtbase,
  stdenv,
  wrapQtAppsHook,
  zlib,
}:

let
  deps = [
    stdenv.cc.cc.lib
    e2fsprogs
    freetype
    fontconfig
    libffi
    libGL
    libgpg-error
    qtbase
    zlib
    openssl
  ];

  version = "3.1.0";

  hostSystem = stdenv.hostPlatform.system;

  selectSystem = attrs: attrs.${hostSystem} or (throw "unsupported system: ${hostSystem}");

  platform = selectSystem {
    x86_64-linux = "x64";
    aarch64-linux = "arm64";
  };

  hash = selectSystem {
    x86_64-linux = "sha256-j/rrUKSpjI2ly0o1WxcIPLc0rId6ZRRhc7AI3nGTVgM=";
    aarch64-linux = "sha256-vsOsa1beaJHQwqXWqq7Ib0KKx4Ntdebfm+QILEXbPyI=";
  };

  libraryPath = lib.makeLibraryPath [ openssl ];

in

stdenv.mkDerivation {
  strictDeps = true;

  pname = "happ";
  inherit version;

  src = fetchurl {
    url = "https://github.com/Happ-proxy/happ-desktop/releases/download/${version}/Happ.linux.${platform}.deb";
    inherit hash;
  };

  buildInputs = deps;

  nativeBuildInputs = [
    autoPatchelfHook
    wrapQtAppsHook
    dpkg
  ];

  qtWrapperArgs = [
    "--prefix LD_LIBRARY_PATH : ${libraryPath}"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/happ $out/bin

    mv usr/share/* $out/share
    mv usr/bin/* $out/bin

    mv opt/happ/* $out/share/happ

    ln -s $out/share/happ/bin/Happ $out/bin
    ln -s $out/share/happ/bin/happd $out/bin

    sed -i "s|Exec.*$|Exec=$out/bin/Happ %f|" $out/share/applications/Happ.desktop

    runHook postInstall
  '';

  meta = {
    homepage = "https://happ.su/";
    description = "Happ Proxy Utility";
    changelog = "https://github.com/Happ-proxy/happ-desktop/releases/tag/${version}";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unfree;
    mainProgram = "Happ";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nekitdev ];
  };
}
