{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  ...
}:
let
  kernelDir = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  modOutDir = "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtw89-nix";

  kernelDirFlag = "KDIR=${kernelDir}";

in

stdenv.mkDerivation {
  pname = "rtw89";
  version = "latest";

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtw89";
    rev = "main";
    sha256 = "sha256-ZgdDTnTVRQxu/CQkMa+P4TC7P68kSuXSdeGTlFm/M6A=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernel.commonMakeFlags ++ [ kernelDirFlag ];

  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall

    mkdir -p ${modOutDir}

    find . -name "*.ko" -exec cp --parents {} ${modOutDir} \;
    find ${modOutDir} -name "*.ko" -exec xz -f {} \;

    runHook postInstall
  '';

  meta = {
    description = "Realtek drivers";
    homepage = "https://github.com/morrownr/rtw89";
    maintainers = with lib.maintainers; [ nekitdev ];
    platforms = lib.platforms.linux;
  };
}
