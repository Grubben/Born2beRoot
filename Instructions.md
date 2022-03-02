# Setting up VirtualBox
-Settings
-Storage
	-Controller: IDE
	-<blue disk> => right click and select debian iso
-Network
	Bridged Adapter

# Running the Virtual Image
## Set-Up
-choose generic location and stuff ...

## Network config
Hostname: amaria-d42
Domain name: 

## Users and Passwords
root_pwd: root 
FullName: Antonio
username: amaria-d
password: born2

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


# Set Up
## apt vs apt-get vs aptitude
APT is a vast project, whose original plans included a graphical interface. It is based on a library which contains the core application, and apt-get is the first front end — command-line based — which was developed within the project. apt is a second command-line based front end provided by APT which overcomes some design mistakes of apt-get.

Both tools are built on top of the same library and are thus very close, but the default behavior of apt has been improved for interactive use and to actually do what most users expect. The APT developers reserve the right to change the public interface of this tool to further improve it. On the opposite, the public interface of apt-get is well defined and will not change in any backwards incompatible way. It is thus the tool that you want to use when you need to script package
installation requests.

Numerous other graphical interfaces then appeared as external projects: synaptic, aptitude (which includes both a text mode interface and a graphical one — even if not complete yet), wajig, etc. The most recommended interface is apt.

## AppArmor
{ checkout AppArmor.epub }

## Sudo
```console
apt install sudo
```

## GROUPS
Creating the group user42
```shell
groupadd user42
```
```console
usermod -aG sudo amaria-d
usermod -aG user42 amaria-d
```
## SSH
In /etc/ssh/sshd_config Write:
	Port 4242
	PermitRootLogin no
```console
sudo service ssh restart
```

## Password Policy
In /etc/login.defs Write:
	PASS_MAX_DAYS	30
	PASS_MIN_DAYS	2
	PASS_WARN_AGE	7
```shell
sudo apt install libpam-pwquality cracklib-runtime
```
In /etc/pam.d/common-password Write:
	password    requisite      pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7

Note that root is not asked for an old password so the checks that compare the old and new password are not performed. So, basically, the phrase `The following rule does not apply to the root password` means you can't make difok=7 work for root and not that you must create a separate rule for root.
```shell
sudo reboot
```

## Configuring Sudo
To read the option see
```man sudoers```
In /etc/sudoers Write:
#	Defaults	insults
	Defaults	passwd_tries=3
	Defaults	badpass_message="Wrong, try again!"
	Defaults	log_input, log_output
	Defaults	iolog_file="/var/log/sudo/sudo.log"

	Defaults	requiretty
	Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

## FIREWALL
```console
# apt install -y nftables
```

## MISC
Find ip
```ip a```

Shut down
```systemctl poweroff```

Add a user
```useradd test```

Add or Change a password
```passwd```
or
```sudo passwd test```
