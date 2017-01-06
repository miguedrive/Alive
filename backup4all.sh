#!/bin/bash
# Fancy text
echo "Backing up databases..."

# Create 'bkp' directory 
mkdir /root/bkp

# Access into bkp
cd /root/bkp

# MySQL dump, backup all DB's
mysqldump --all-databases > everydb.sql

# Now, we should call (or just execute) rotate.sh, the code looks like this:

#### Rotate script for files
#### v1.2 (4-1-17)
####
#Assign variables for Current file (the one that is written), and the "new" one (the 'old' one with name YmdHM)

CUR="/root/bkp/everydb.sql" 
NEW="${CUR}.$(date +%Y-%m-%d---%H-%M)"


#### Rename the log
mv ${CUR} ${NEW}
touch ${CUR}
rm /root/bkp/everydb.sql
#### Wait 1 sec before writing the new file
sleep 1
#### Compress the old files
#### xz("-9 ${NEW}")

#Rsync to bkp server
rsync /root/bkp/everydb.sql root@192.168.1.7:/backups2.vg5-edicion.Contenidos/BackupDBs/


