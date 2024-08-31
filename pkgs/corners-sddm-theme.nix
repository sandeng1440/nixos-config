{ stdenvNoCC, fetchFromGitHub, pkgs, ...}:
{
  stdenvNoCC.mkDerivation rec {
    pname = "sddm-theme-corners";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -r $src/corners/ $out/share/sddm/themes/
    '';
    src = fetchFromGitHub {
      owner = "aczw";
      repo = "sddm-theme-corners";
      #sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
    };
  };
}
