{ sources ? import ./sources.nix
, config ? { }
, overlays ? [ ]
}:

import sources.nixpkgs {
  overlays = overlays;
  config = config;
}
