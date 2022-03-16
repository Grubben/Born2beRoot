wall """Architecture: $(uname -a)
CPU physical: $(lscpu | grep "^CPU(s):" | awk -F" " '{print $2}')
vCPU: $(lscpu | grep "Core(s)" | awk -F" " '{print $2}')
Memory Usage: $(free -m | grep Mem | awk -F " " '{printf "%d/%d (%.2f%%)", $4, $2, $4/$2*100}')
Disk Usage: $(df -h / | grep '/' | awk -F " " '{printf "%s/%s (%s)", $4, $2, $5}')
$(top -n 1 | grep %Cpu | awk -F " " '{printf "%%Cpu(s): %s%%", $2}')
$(last reboot --time-format iso | sed -n 2p | awk -F " " '{printf "Last boot: %s", $5}')
$(printf "LVM use: "
if [ $(lsblk | grep /home | awk -F" " '{print $6}') = "lvm" ]; then
	printf "yes";
else
	printf "no";
fi)
TCP Connections: $(ss -t | grep ESTAB| wc -l)
Active Users: $(who | wc -l)
Network: $(ip a | grep inet | sed -n 3p | awk -F " " '{print $2}') $(ip link | sed -n 4p | awk -F " " '{printf "(%s)", $2}')
Sudo commands: $(journalctl _COMM=sudo | grep COMMAND | wc -l)
"""
