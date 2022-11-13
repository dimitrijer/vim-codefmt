let
  pkgs = import ./nix/default.nix { };
  vroom = pkgs.python3Packages.callPackage ./nix/vroom.nix { };
  myPython = pkgs.python3.withPackages (python-packages: [
    pkgs.python3Packages.pynvim
    vroom
  ]);
  myNeovim = pkgs.neovim.override {
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          vim-maktaba
        ];
      };
    };
  };
in
pkgs.mkShell {
  # GNU ls has different CLI options than Darwin ls.
  shellHooks = ''
    alias ll='ls -alh --color=auto'
    alias ls='ls -ah --color=auto'
  '';

  buildInputs = [
    myNeovim
    myPython
    pkgs.haskellPackages.ormolu
  ];
}
