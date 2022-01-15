# Setting up VirtualBox
-Settings
-Storage
-Controller: IDE
-<blue disk> => right click and select debian iso

# Running the Virtual Image
## Set-Up
-choose generic location and stuff ...
root_pwd: root
FullName: born2beroot
username: beroot
password: beroot

## Disk Partioning
-Guided partitioning
-... use entire disk and set up encrypted LVM
encr_passw: encrypted

## Software selection
-SSH server
-standard system utilities

## GRUB boot loader
-Yes install
-/dev/sda

# MISTAKES !!!!
gotta make another partition for home
