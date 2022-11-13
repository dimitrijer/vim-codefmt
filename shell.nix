let
  pkgs = import ./nix/default.nix { };
  vroom = pkgs.python3Packages.callPackage ./nix/vroom.nix { };
  myPython = pkgs.python3.withPackages (python-packages: [
    pkgs.python3Packages.pynvim
    vroom
  ]);
  vim-glaive = pkgs.vimUtils.buildVimPlugin {
    name = "vim-glaive";
    src = pkgs.fetchFromGitHub {
      owner = "google";
      repo = "vim-glaive";
      rev = "3c5db8d279f86355914200119e8727a085863fcd";
      hash = "sha256-uNDz2MZrzzRXfVbS5yUGoJwa6DMV63yZXO31fMUrDe8=";
    };
    meta.homepage = "https://github.com/google/vim-glaive";
  };
  myNeovim = pkgs.neovim.override {
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          vim-glaive
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
