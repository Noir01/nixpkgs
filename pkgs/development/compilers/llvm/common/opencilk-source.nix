{ pkgs, fetchFromGitHub, runCommand }:

let
  version = "v3.0";
  
  opencilkProject = fetchFromGitHub {
    owner = "OpenCilk";
    repo = "opencilk-project";
    rev = "opencilk/${version}";
    sha256 = "0jfbsi12fvqnacs21mg8fh1azl13lqy58ilmvzhvama3qw56k020";
  };

  cheetah = fetchFromGitHub {
    owner = "OpenCilk";
    repo = "cheetah";
    rev = "opencilk/${version}";
    sha256 = "0dwwm621x0rlyybnindgwyyxvj0q4iqzdpss40vkkv5h5awdh658";
  };

  productivityTools = fetchFromGitHub {
    owner = "OpenCilk";
    repo = "productivity-tools";
    rev = "opencilk/${version}";
    sha256 = "1zwls3x5bhhwr40mgawr51jz8yl0jpxfy3i5ahxmlk7ymnyp37qk";
  };

in runCommand "opencilk-source-${version}" {} ''
  mkdir -p $out
  cp -r ${opencilkProject}/* $out/
  chmod -R u+w $out
  
  # Ensure cheetah and cilktools directories are replaced with fetched sources
  rm -rf $out/cheetah $out/cilktools
  cp -r ${cheetah} $out/cheetah
  cp -r ${productivityTools} $out/cilktools
''
