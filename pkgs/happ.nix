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
  ...
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

  version = "4.2.1";

  hostSystem = stdenv.hostPlatform.system;

  selectSystem = attrs: attrs.${hostSystem} or (throw "unsupported system: ${hostSystem}");

  platform = selectSystem {
    x86_64-linux = "x64";
    aarch64-linux = "arm64";
  };

  hash = selectSystem {
    x86_64-linux = "sha256-vIvAvWH4/ZblxYEXzthc2wrcPCinA+eWXs3/EIlUrnU=";
    aarch64-linux = "sha256-g6WrSlwkThLCq+gcUDCRkAjMA5XuDcvzHgtCw79OChg=";
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

    substituteInPlace $out/share/applications/Happ.desktop --replace-fail "/opt/happ/bin/Happ" "$out/bin/Happ"

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
