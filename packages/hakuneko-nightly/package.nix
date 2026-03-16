{
  autoPatchelfHook,
  dpkg,
  fetchurl,
  makeDesktopItem,
  makeWrapper,
  udev,
  undmg,
  stdenv,
  lib,
  wrapGAppsHook3,
  alsa-lib,
  nss,
  nspr,
  systemd,
  libxtst,
  libxscrnsaver,
}:
let
  pname = "hakuneko-nightly";
  version = "8.3.4";

  meta = {
    description = "Manga & Anime Downloader";
    homepage = "https://sourceforge.net/projects/hakuneko/";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [
      nloomans
    ];
    platforms = [
      "x86_64-linux"
      "x86_64-darwin"
    ];
    mainProgram = "hakuneko";
  };

  desktopItem = makeDesktopItem {
    desktopName = "HakuNeko Nightly Desktop";
    genericName = "Manga & Anime Downloader";
    categories = [
      "Network"
      "FileTransfer"
    ];
    exec = "hakuneko --no-sandbox";
    icon = "hakuneko-desktop";
    name = "hakuneko-desktop";
  };

  linux = stdenv.mkDerivation {
    inherit pname version meta;

    src = fetchurl {
      url = "https://github.com/manga-download/hakuneko/releases/download/nightly-20200705.1/hakuneko-desktop_${version}_linux_amd64.deb";
      sha256 = "48e9a77015695fe69390ac99b54184cf793f31c3452d174fcf41052ccb2ae211";
    };

    dontBuild = true;
    dontConfigure = true;
    dontPatchELF = true;
    dontWrapGApps = true;

    # TODO: migrate off autoPatchelfHook and use nixpkgs' electron
    nativeBuildInputs = [
      autoPatchelfHook
      dpkg
      makeWrapper
      wrapGAppsHook3
    ];

    buildInputs = [
      alsa-lib
      nss
      nspr
      libxscrnsaver
      libxtst
      systemd
    ];

    unpackPhase = ''
      # The deb file contains a setuid binary, so 'dpkg -x' doesn't work here
      dpkg --fsys-tarfile $src | tar --extract
    '';

    installPhase = ''
      cp -R usr "$out"
      # Overwrite existing .desktop file.
      cp "${desktopItem}/share/applications/hakuneko-desktop.desktop" \
         "$out/share/applications/hakuneko-desktop.desktop"
    '';

    runtimeDependencies = [
      (lib.getLib udev)
    ];

    postFixup = ''
      makeWrapper $out/lib/hakuneko-desktop/hakuneko $out/bin/hakuneko \
        "''${gappsWrapperArgs[@]}"
    '';
  };

  darwin = stdenv.mkDerivation {
    inherit pname version meta;

    src = fetchurl {
      url = "https://github.com/manga-download/hakuneko/releases/download/nightly-20200705.1/hakuneko-desktop_${version}_macos_amd64.dmg";
      hash = "sha256-5b7hNVi2/50muGjSIfgssmgbG75aOfwHfR+pVptTw3A=";
    };

    sourceRoot = "HakuNeko Desktop/HakuNeko Desktop.app";

    nativeBuildInputs = [
      makeWrapper
      undmg
    ];

    dontBuild = true;
    dontConfigure = true;
    dontFixup = true;

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/Applications/HakuNeko Desktop.app" "$out/bin"
      cp -R . "$out/Applications/HakuNeko Desktop.app"
      makeWrapper "$out/Applications/HakuNeko Desktop.app/Contents/MacOS/HakuNeko" "$out/bin/hakuneko"
      runHook postInstall
    '';
  };
in
if stdenv.hostPlatform.isDarwin then darwin else linux
