{
  description = "My Personal NixOS System Flake Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      nixos-hardware.url = "github:NixOS/nixos-hardware/master";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-colors.url = "github:misterio77/nix-colors";

      sops-nix = {
        url = "github:Mic92/sops-nix";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.nixpkgs-stable.follows = "nixpkgs";
      };

      firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = { self, nixpkgs, home-manager, firefox-addons, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;

      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;

      homeManagerModules = import ./modules/home-manager;

      # devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      # formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        laptop = lib.nixosSystem {
          modules = [ ./hosts/laptop ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "angelos@laptop" = lib.homeManagerConfiguration {
          modules = [ ./home/angelos/laptop.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
