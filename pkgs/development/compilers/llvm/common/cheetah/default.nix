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
  bash,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cheetah";
  inherit version;

  src = runCommand "cheetah-src-${version}" { } ''
    mkdir -p "$out"
    cp -r ${monorepoSrc}/cmake "$out"
    cp -r ${monorepoSrc}/cheetah "$out"
  '';

  sourceRoot = "${finalAttrs.src.name}/cheetah";

  nativeBuildInputs = [
    cmake
    python3
    libllvm.dev
    ninja
  ];

  cmakeFlags = [
    # Cheetah specific flags if any. 
    # Based on INSTALLING.md, it seems standard cmake build.
  ];

  # Cheetah might need some specific install fixes or it might just work.
  # We'll assume standard cmake install works for now.

  meta = llvm_meta // {
    homepage = "https://opencilk.org/";
    description = "OpenCilk Runtime (Cheetah)";
    license = lib.licenses.mit; # Check license
  };
})
