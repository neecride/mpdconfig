{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

let
  # Import du dépôt stable-diffusion-webui-nix
  stable-diffusion-webui-nix = builtins.fetchGit {
    url = "https://github.com/Janrupf/stable-diffusion-webui-nix.git";
    ref = "main";
    # SHA du commit récent pour plus de stabilité (optionnel)
    # rev = "2aeb76f52f72c7a242f20e9bc47cfaa2ed65915d";
  };
  
  # Package importé depuis le dépôt
  sd-webui = import stable-diffusion-webui-nix {
    inherit pkgs;
  };
  
in {
  environment.systemPackages = [
    # --- TES APPLICATIONS STABLES ---
    # Décommente et ajoute ce que tu veux :
    # pkgs.btop
    # pkgs.htop
    # pkgs.neovim
    # pkgs.git

    # --- TES APPLICATIONS INSTABLES ---
    # pkgs-unstable.btop
    # pkgs-unstable.obsidian

    # --- STABLE DIFFUSION - Interface Forge (recommandée) ---
    # Pour NVIDIA (CUDA)
    sd-webui.packages.${pkgs.system}.forge.cuda
    
    # Pour AMD (ROCm) - décommente si nécessaire et commente ci-dessus
    # sd-webui.packages.${pkgs.system}.forge.rocm
    
    # Alternative : Interface ComfyUI (nodale, plus avancée)
    # sd-webui.packages.${pkgs.system}.comfy.cuda
    # sd-webui.packages.${pkgs.system}.comfy.rocm
  ];

  # --- CONFIGURATION DU CACHE (pour accélérer les installations) ---
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    # Options pour améliorer les performances de téléchargement
    auto-optimise-store = true;
  };

  # --- CONFIGURATION SPÉCIFIQUE À GLF OS (NE PAS MODIFIER SANS RAISON) ---
  # Voici les options désactivables que tu as déjà dans ton fichier

  # Désactiver Firefox / Disable Firefox
  # glf.firefox.enable = lib.mkForce false;

  # Désactiver le pack gaming / Disable gaming pack
  # glf.gaming.enable = lib.mkForce false;

  # Désactiver le pilote NVIDIA / Disable NVIDIA driver
  # glf.nvidia.enable = lib.mkForce false;

  # Désactiver la compatibilité et les outils d'impression / Disable printing
  # glf.printing.enable = lib.mkForce false;

  # ⚠️ Désactiver les mises à jour automatiques / Disable automatic updates
  # glf.autoUpgrade = false;

  # Activer le support RAID logiciel / Enable software RAID
  # boot.swraid.enable = true;

  # Ajouter des modules kernel supplémentaires / Add extra kernel modules
  # boot.initrd.kernelModules = [ "btrfs" "nbd" ];

  # --- AJOUTE TES CONFIGURATIONS PERSONNALISÉES ICI ---
  # Par exemple :
  # programs.firefox.enable = true;
  # services.flatpak.enable = true;
  # services.pipewire.enable = true;
}
