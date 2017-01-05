#!/bin/bash
# Rotate script for files 
# v1.1 (4-1-17)

# Assign variables for Current file (the one that is written), and the "new" one (the 'old' one with name YmdHM)
CUR="/root/bkp/bkpsql?" #We must edit this line with the directory where the extra HD is mounted
#e.g : CUR="/mnt/logs/sdb/pcap.log"
NEW="${CUR}.$(date +%Y-%m-%d---%H-%M)"

# Rename the log
mv ${CUR} ${NEW}

touch ${CUR}
#rm "/root/bkp/bkpsql?"

# Wait 1 sec before writing the new file
sleep 1

# Compress the old files
xz -9 ${NEW}
