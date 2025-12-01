{
  lib,
  stdenv,
  llvm_meta,
  release_version,
  version,
  monorepoSrc ? null,
  runCommand,
  cmake,
  ninja,
  python3,
  libllvm,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cilktools";
  inherit version;

  src = runCommand "cilktools-src-${version}" { } ''
    mkdir -p "$out"
    cp -r ${monorepoSrc}/cmake "$out"
    cp -r ${monorepoSrc}/cilktools "$out"
  '';

  sourceRoot = "${finalAttrs.src.name}/cilktools";

  nativeBuildInputs = [
    cmake
    python3
    libllvm.dev
    ninja
  ];

  meta = llvm_meta // {
    homepage = "https://opencilk.org/";
    description = "OpenCilk Productivity Tools";
    license = lib.licenses.mit; # Check license
  };
})
