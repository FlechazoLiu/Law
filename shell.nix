{pkgs, ...}:
pkgs.mkShell rec {
  name = "python-venv";
  venvDir = "./.venv";

  packages = with pkgs; [texliveFull graphviz pdf2svg elan gnumake poetry triton-llvm];

  LD_LIBRARY_PATH =
    pkgs.lib.makeLibraryPath ([pkgs.stdenv.cc.cc] ++ packages);

  shellHook = ''
    poetry install
  '';
}
