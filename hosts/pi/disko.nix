_: {
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          firmware = {
            label = "FIRMWARE";

            # microsoft basic data
            type = "0700";

            attributes = [
              0 # required partition
            ];

            # ought to be enough
            size = "1G";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/firmware";

              # options
              mountOptions = [
                "noatime" # do not update access time
                "noauto" # do not mount automatically
                "x-systemd.automount" # mount on demand
                "x-systemd.idle-timeout=1min" # unmount after 1 minute of inactivity
              ];
            };
          };
          boot = {
            label = "BOOT";

            # efi system partition (esp)
            type = "EF00";

            attributes = [
              2 # legacy bios bootable
            ];

            # should be enough
            size = "1G";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";

              # options
              mountOptions = [
                # same as in firmware
                "noatime" # do not update access time
                "noauto" # do not mount automatically
                "x-systemd.automount" # mount on demand
                "x-systemd.idle-timeout=1min" # unmount after 1 minute of inactivity
                # permissions
                "fmask=0077" # file permissions
                "dmask=0077" # directory permissions
              ];
            };
          };
          swap = {
            label = "SWAP";

            # same size as RAM
            size = "16G";

            content = {
              type = "swap";
              randomEncryption = true;
            };
          };
          # main partition
          luks = {
            label = "CRYPTED";
            # use the rest of the disk
            size = "100%";

            content = {
              type = "luks";
              name = "crypted";
              settings = {
                # trim support
                allowDiscards = true;
                # yubikey support
                crypttabExtraOpts = [
                  "fido2-device=auto"
                  "token-timeout=30"
                ];
              };
              content = {
                type = "zfs";
                pool = "rpool"; # zroot
              };
            };
          };
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";

        # properties
        options = {
          # 4k sector size
          ashift = "12";
          # enable automatic trimming
          autotrim = "on";
        };

        rootFsOptions = {
          # raspberry pi's cpu is not so powerful
          compression = "lz4";
          # disable access time
          atime = "off";
          # store extended attributes directly
          xattr = "sa";
          # posix acl
          acltype = "posixacl";
          # canonical unicode representation
          normalization = "formD";
          # use automatic data node sizes
          dnodesize = "auto";
          # do not mount automatically
          mountpoint = "none";
          # do not allow mounting
          canmount = "off";
        };

        # postCreateHook?

        datasets = {
          # local data which can be easily recomputed or downloaded, like the nix store
          local = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };

          # nix
          "local/nix" = {
            type = "zfs_fs";
            # allow managing with traditional tools
            options.mountpoint = "legacy";
            # nixos configuration mountpoint
            mountpoint = "/nix";
          };

          # system data
          system = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };

          # root
          "system/root" = {
            type = "zfs_fs";
            # allow managing with traditional tools
            options.mountpoint = "legacy";
            # system root
            mountpoint = "/";
          };

          # variable
          "system/var" = {
            type = "zfs_fs";
            # allow managing with traditional tools
            options.mountpoint = "legacy";
            # system variable
            mountpoint = "/var";
          };

          # safe data
          safe = {
            type = "zfs_fs";
            options = {
              # store copies
              copies = "2";
              mountpoint = "none";
            };
          };

          # home
          "safe/home" = {
            type = "zfs_fs";
            # allow managing with traditional tools
            options.mountpoint = "legacy";
            # user home
            mountpoint = "/home";
          };

          "safe/var/lib" = {
            type = "zfs_fs";
            # allow managing with traditional tools
            options.mountpoint = "legacy";
            # variable state
            mountpoint = "/var/lib";
          };
        };
      };
    };
  };
}
