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

### New passwords
Changing the root password
```shell
sudo passwd root
Ant0nio123
```

Changing amaria-d's password
```shell
sudo passwd amaria-d
Born2beRoot
```

## Configuring Sudo
To read the option see
```
man sudoers
```
In /etc/sudoers Write:
#	Defaults	insults
	Defaults	passwd_tries=3
	Defaults	badpass_message="Wrong, try again!"
	Defaults	log_input, log_output
	Defaults	iolog_file="/var/log/sudo/sudo.log"

	Defaults	requiretty
	Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

## FIREWALL
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-debian-10
```console
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw allow 4242
sudo ufw enable
sudo ufw status verbose
```

## Monitoring
{ checkout monitoring.sh }
	{
		hostnamectl
		Architecture of OS
		?
		Kernel Version
		uname -v
	}	uname -a
	echo CPU physical: $(lscpu | grep "^CPU(s):")
	echo vCPU: $(lscpu | grep "Core(s)")
	echo Memory Usage: $(free -m | grep Mem | awk -F " " '{printf "%d/%d (%.2f%%)", $4, $2, $4/$2*100}')
	echo Disk Usage: $(df -h / | grep '/' | awk -F " " '{printf "%s/%s (%s)", $4, $2, $5}')
	top -n 1 | grep %Cpu | awk -F " " '{printf "%%Cpu(s): %s%%", $2}'
	last reboot --time-format iso | sed -n 2p | awk -F " " '{printf "Last boot: %s", $5}'
	printf "LVM use: "
	if [ $(lsblk | grep /home | awk -F" " '{print $6}') = "lvm" ]; then
		printf "yes";
	else
		printf "no";
	fi
	printf "TCP Connections: %s" $(ss -t | grep ESTAB| wc -l)
	printf "Active Users: %s" $(who | wc -l)
	printf "Network: %s (%s)" $(ip a | grep inet | sed -n 3p | awk -F " " '{print $2}') $(ip link | sed -n 4p | awk -F " " '{print $2}')
	\# sudo apt install net-tools
	echo Sudo commands: $(journalctl _COMM=sudo | grep COMMAND | wc -l)

Pass `monitoring.sh` to `/usr/local/bin`
```console
sudo crontab -e
```
Then write:
```text
@reboot sleep 20; sh /usr/local/bin/monitoring.sh
*/10 * * * * /usr/local/bin/monitoring.sh
```

## Hostname
Show hostname
```console
hostname
```
Show hostname for connection (for example ssh)
```console
hostname -A
```

Change Hostname
In /etc/hostname Replace:
	new-hostname-here
In /etc/hosts Replace:
	127.0.0.1	localhost
	127.0.0.1	old-hostname
With:
	127.0.0.1	localhost
	127.0.0.1	new-hostname-here


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

Send files/folders to remote location
```
scp -P 4242 monitoring.sh amaria-d@10.11.248.58:/home/amaria-d
```

See groups
```groups```

Show all users
```cat /etc/passwd```
