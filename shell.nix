let
  pkgs = import ./nix/default.nix { };
  vroom = pkgs.python3Packages.callPackage ./nix/vroom.nix {};
  python3 = pkgs.python3.withPackages (python-packages: [vroom]);
in
pkgs.mkShell {
  # GNU ls has different CLI options than Darwin ls.
  shellHooks = ''
    alias ll='ls -alh --color=auto'
    alias ls='ls -ah --color=auto'
  '';

  buildInputs = with pkgs; [
    vim
    python3
  ];
}
