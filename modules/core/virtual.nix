{ currentPi, ... }:
if currentPi then
  {
    virtualisation.docker.enable = true;
  }
else
  {
    virtualisation = {
      docker.enable = true;

      libvirtd = {
        enable = true;

        qemu = {
          swtpm.enable = true;
        };
      };

      spiceUSBRedirection.enable = true;
    };

    programs.virt-manager.enable = true;
  }
