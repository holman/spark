{
  description = "▁▂▃▅▂▇ in your shell.";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.spark;

    packages.x86_64-linux.spark =
      let pkgs = import nixpkgs { system = "x86_64-linux"; };
      in pkgs.writeShellScriptBin "spark" (builtins.readFile ./spark);
  };
}
