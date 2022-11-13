let
  pkgs = import ./nix/default.nix { };
in
pkgs.mkShell {
  # GNU ls has different CLI options than Darwin ls.
  shellHooks = ''
    alias ll='ls -alh --color=auto'
    alias ls='ls -ah --color=auto'
  '';

  buildInputs = with pkgs; [
    python3
  ];
}
