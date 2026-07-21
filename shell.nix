{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtshadertools
    qt6.qtsvg
    qt6.qt5compat
    cmake
    gcc
    libsixel
    pkg-config
  ];

  shellHook = ''
    # Find Qt QML module paths dynamically (NixOS store paths change per build)
    QTDECL="$(pkg-config --variable=prefix Qt6Qml 2>/dev/null || true)"
    QT5COMPAT="$(find /nix/store -maxdepth 1 -name '*qt5compat*' -type d 2>/dev/null | sort | tail -1)"

    # Build the QML import path
    QML_PATH="$(pwd)/qmltermwidget"
    [ -n "$QTDECL" ] && QML_PATH="$QML_PATH:$QTDECL/lib/qt-6/qml"
    [ -n "$QT5COMPAT" ] && QML_PATH="$QML_PATH:$QT5COMPAT/lib/qt-6/qml"

    export QML2_IMPORT_PATH="$QML_PATH"
    echo "QML2_IMPORT_PATH=$QML2_IMPORT_PATH"
  '';
}
