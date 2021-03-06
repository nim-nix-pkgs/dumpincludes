{
  description = ''See where your exe size comes from.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."dumpincludes-master".dir   = "master";
  inputs."dumpincludes-master".owner = "nim-nix-pkgs";
  inputs."dumpincludes-master".ref   = "master";
  inputs."dumpincludes-master".repo  = "dumpincludes";
  inputs."dumpincludes-master".type  = "github";
  inputs."dumpincludes-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."dumpincludes-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}