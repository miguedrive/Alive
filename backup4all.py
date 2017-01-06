#!/usr/bin/env python
# Install sh pkg; pip install sh, then import it
import sh
# Fancy text
print ("Backing up databases...")
# Create 'bkp' directory 
sh.mkdir("/root/bkp")
# Access into bkp
sh.cd('/root/bkp')
# MySQL dump, backup all DB's
sh.mysqldump('--all-databases > everydb.sql')
# Now, we should call (or just execute) rotate.sh, the code looks like this:

#### Rotate script for files
#### v1.1 (4-1-17)
####
#Assign variables for Current file (the one that is written), and the "new" one (the 'old' one with name YmdHM)
sh.CUR=("/root/bkp/bkpsql") 
#### e.g : CUR="/mnt/logs/sdb/pcap.log"
sh.NEW=("${CUR}.$(date +%Y-%m-%d---%H-%M)")
####
#### Rename the log
sh.mv("${CUR} ${NEW}")
####
sh.touch(${CUR})
sh.rm("/root/bkp/bkpsql")
####
#### Wait 1 sec before writing the new file
sh.sleep("1")
####
#### Compress the old files
sh.xz("-9 ${NEW}")
#
#
#Rsync to bkp server
sh.rsync("everydb.sql root@192.168.1.4:/root/bkp")
#clean up everything?
