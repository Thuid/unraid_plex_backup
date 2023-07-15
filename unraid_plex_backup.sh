#!/bin/bash

# Special thanks to unRAID users "Cpt. Chaz" and "Energen" for the backup script
# Look for thre "Cpt. Chaz" YouTube Video at https://www.youtube.com/watch?v=T6wdjkkTq-0

#dir = PLEX SOURCE LOCATION
dir="/mnt/cache/appdata/plex/Library/Application Support/Plex Media Server/"
#dest = BACKUP DESTINATION
dest="/mnt/user/Backups/Kal-El/Plex/$(date +"%m-%d-%Y")/"
#pdest = PARENT FOLDER OF DESTINATION
pdest="/mnt/user/Backups/Kal-El/Plex/"

#                         DON'T MODIFY BELOW THIS LINE AFTER SETUP
#-------------------------------------------------------------------------------------------------------

echo 'Backing Up Plex Databases'
# Note: Remove 'n' from rsync switch command below once tested so it will function normally
rsync -rvhPRn --stats "$dir/Plug-in Support/./Databases/" $dest

sleep 5

echo ' '
echo ' '
echo 'Backing Up Plex Preferences.xml'
# Note: Remove 'n' from rsync switch command below once tested so it will function normally
rsync -rvhPn --stats "$dir/Preferences.xml" $dest

sleep 5

#chmod -R 777 $pdest

echo ' '
echo ' '
echo "Searching for (and deleting) Old Backups"

echo "Should Only Take a Second"

#-------------------------------------------------------------------------------------------------------
#                         DON'T MODIFY ABOVE THIS LINE AFTER SETUP

#ENTER NUMERIC VALUE OF DAYS AFTER "-MTIME +"
find $pdest* -mtime +3 -exec rm -rfd {} \;

#UNCOMMENT THE NEXT LINE TO ENABLE GUI NOTIFICATION UPON COMPLETION
#/usr/local/emhttp/webGui/scripts/notify -e "Unraid Server Notice" -s "Plex Backup" -d "A copy of the essential Plex data has been backed up, and old backups removed." -i "normal"


echo 'All Done'

exit