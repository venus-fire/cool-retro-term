{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtshadertools
    qt6.qtsvg
    cmake
    gcc
    libsixel
    pkg-config
  ];

  shellHook = ''
    export QT_PLUGIN_PATH="${pkgs.qt6.qtbase.bin}/${pkgs.qt6.qtbase.qtPluginPrefix}"
    export QML2_IMPORT_PATH="${pkgs.qt6.qtdeclarative.bin}/${pkgs.qt6.qtdeclarative.qtQmlPrefix}"
  '';
}
