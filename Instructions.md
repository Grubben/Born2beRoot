# Setting up VirtualBox
-Settings
-Storage
-Controller: IDE
-<blue disk> => right click and select debian iso

# Running the Virtual Image
## Set-Up
-choose generic location and stuff ...

## Network config
Hostname: amaria-d42
Domain name: born2

## Users and Passwords
root_pwd: root
FullName: born2beroot
username: beroot
password: beroot

## Disk Partioning
-Guided partitioning
-... use entire disk and set up encrypted LVM
-Separate /home partition
encr_passw: encrypted

## Software selection
-SSH server
-standard system utilities

## GRUB boot loader
-Yes install
-/dev/sda

# MISTAKES !!!!
gotta make another partition for home

# apt vs apt-get vs aptitude
APT is a vast project, whose original plans included a graphical interface. It is based on a library which contains the core application, and apt-get is the first front end — command-line based — which was developed within the project. apt is a second command-line based front end provided by APT which overcomes some design mistakes of apt-get.

Both tools are built on top of the same library and are thus very close, but the default behavior of apt has been improved for interactive use and to actually do what most users expect. The APT developers reserve the right to change the public interface of this tool to further improve it. On the opposite, the public interface of apt-get is well defined and will not change in any backwards incompatible way. It is thus the tool that you want to use when you need to script package
installation requests.

Numerous other graphical interfaces then appeared as external projects: synaptic, aptitude (which includes both a text mode interface and a graphical one — even if not complete yet), wajig, etc. The most recommended interface is apt.
