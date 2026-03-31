{ self, inputs, ... }:
{

  flake.nixosModules.ldd =
    { pkgs, ... }:
    {
      programs.nix-ld.enable = true;

      programs.nix-ld.libraries = with pkgs; [
        # toolchain
        stdenv.cc.cc

        # core
        zlib
        glib
        openssl

        # X11
        libX11
        libXcursor
        libXrandr
        libXi
        libXext
        libXrender
        libXcomposite
        libXdamage
        libXfixes
        libXtst
        libXau
        libXdmcp
        libxcb

        # graphics
        libGL
        mesa

        # fonts
        freetype
        fontconfig
        expat

        # audio
        alsa-lib
        libpulseaudio

        # dbus
        dbus

        # kerberos
        krb5

        # glib deps
        glib
        libffi
        pcre2

        # NSS
        nss
        nspr

        # C++
        stdenv.cc.cc.lib

        # misc
        libxkbcommon
      ];
    };
}
