{ pkgs ? import <nixpkgs> {
    overlays = [ (import (fetchTarball "https://github.com/input-output-hk/iohk-nix/tarball/7737550ee747584471c047df9172ad459fa56247" + "/overlays/crypto/")) ];
  } 
}:

let cardano-node = import (
      pkgs.fetchFromGitHub {
        owner = "input-output-hk";
        repo = "cardano-node";
        rev = "1.35.4";
        sha256 = "1j01m2cp2vdcl26zx9xmipr551v3b2rz9kfn9ik8byfwj1z7652r";
      }
    ) {};

    newSecp256k1 = pkgs.secp256k1.overrideAttrs (old: {
	    src = pkgs.fetchFromGitHub {
		    owner = "bitcoin-core";
 		    repo = "secp256k1";
		    rev = "ac83be33d0956faf6b7f61a60ab524ef7d6a473a";
		    sha256 = "11zbgdkfh93lzhd7kisgxnqzcn2k2ryrl9c07ihqdllh83f5any6";
		  };
    });

in
  pkgs.mkShell {
    nativeBuildInputs = [ 
                    cardano-node.cardano-node
                    cardano-node.cardano-cli
                    pkgs.libsodium-vrf 
                    pkgs.blst
                    newSecp256k1
                    pkgs.zlib
                    pkgs.lzma
                    pkgs.pkg-config
    ];
}
