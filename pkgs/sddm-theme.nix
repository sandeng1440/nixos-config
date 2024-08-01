{ stdenv, fetchFromGitHub }:
{
  corners = stdenv.mkDerivation rec {
    pname = "sddm-theme-corners";
    version = "6ff0ff4";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -r $src/corners/ $out/share/sddm/themes/
    '';
    src = fetchFromGitHub {
      owner = "aczw";
      repo = "sddm-theme-corners";
      rev = "6ff0ff455261badcae36cd7d151a34479f157a3c";
      sha256 = "CPK3kbc8lroPU8MAeNP8JSStzDCKCvAHhj6yQ1fWKkY=";
    };
  };

  astronaut = stdenv.mkDerivation rec {
    pname = "sddm-astronaut-theme";
    version = "6ff0ff4";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src/corners/ $out/share/sddm/themes/
    '';
    src = fetchFromGitHub {
      owner = "aczw";
      repo = "sddm-theme-corners";
      rev = "6ff0ff455261badcae36cd7d151a34479f157a3c";
      sha256 = "CPK3kbc8lroPU8MAeNP8JSStzDCKCvAHhj6yQ1fWKkY=";
    };
  };

  sddm-theme-dialog = stdenv.mkDerivation rec {
    pname = "sddm-theme-dialog";
    version = "53f81e3";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sddm-theme-dialog
    '';
    src = fetchFromGitHub {
      owner = "joshuakraemer";
      repo = "sddm-theme-dialog";
      rev = "53f81e322f715d3f8e3f41c38eb3774b1be4c19b";
      sha256 = "qoLSRnQOvH3rAH+G1eRrcf9ZB6WlSRIZjYZBOTkew/0=";
    };
  };
}
