with import <nixpkgs> { };

mkShell {
  buildInputs = [
    pkg-config
    gnumake
    autoconf
    ncurses
    openssl
    libxslt
    fop
    libxml2
    libGL
    libGLU
    # 从处不能使用 wxGTK31，具体细节和 wxGTK 包的默认版本有关。
    # 详情：https://github.com/NixOS/nixpkgs/issues/63579
    (wxGTK30.override {
      withWebKit = true;
      withGtk2 = false;
    })
    xorg.libX11
  ];

  shellHook = ''
    export KERL_CONFIGURE_OPTIONS="--with-ssl=${
      lib.getOutput "out" openssl
    } --with-ssl-incl=${lib.getDev openssl} --without-javac --without-odbc";
  '';
}
