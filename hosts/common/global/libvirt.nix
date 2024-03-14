{ pkgs, ... }: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        # ovmf = {
        #   enable = true;
        #   packages = with pkgs; [ OVMFFull.fd ];
        # };
      };
    };
    # virtualbox.host.enable = true;
    # virtualbox.host.enableExtensionPack = true;
  };

  programs.virt-manager.enable = true;
}
