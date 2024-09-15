# configuration

hardware is difficult without doubt. and that is just in the configurations of
hardware.

it takes tries and tries and tries to guess the right disk descriptor.

## filesystems

files of photos in folders and so much more.

reference: https://nixos.org/manual/nixos/stable/options.html#opt-fileSystems

### chores

#### resising disks

resizing disks is an occasional chore which requires cautious change to unique
identifiers and careful partitions.

backups are optional if the home directories remains intact.

in abundance of ignorance i recommend reinstalling nixos altogether to configure
disks during setup. enter bios with `F11` and be patient during downloads.

once reinstallation completes the `configuration.nix` can be replaced with new
values found in a generated `hardware-configuration.nix`.

### commands

inspecting the realms in which files exist is a somewhat infrequent but nuanced
task that deserves good luck and these commands with `sudo` privilege:

```sh
$ blkid         # block device attributes
$ chown         # change file owner and group
$ chroot        # run shell with special root
$ df            # report file system space usage
$ journalctl    # print logged journaled entries
$ lsblk         # list block devices
$ lvdisplay     # logical volume information
$ mount         # mount a filesystem
$ nano          # another text editor
$ parted        # partition manipulation
$ pvdisplay     # physical volume information
$ resize2fs     # file system resizer
$ rsync         # a fast file copying tool
$ su            # gain super user powers
$ swapoff       # stop paging and swapping
$ swapon        # start pages and swapping
$ umount        # unmount filesystems
$ vgdisplay     # volume group information
```

### directories

meaningful paths to inspect when dealing with disks includes both existing and
uncreated directories:

```sh
/dev/*          # device files
/dev/mapper/*   # logical volumes
/mnt/*          # mounted paths
/proc/*         # process info
/run/*          # service programs
/sys/*          # kernel libraries
```
