#!/bin/bash

# Version 1.0
# Date 10 November 2019
# Copyright 2019, Vishal Vishwakarma

#If any error occur exit bash script.
set -e

# Scope vars
declare backup_path="" #eg. "/var/www/mysql-backups"
declare user="" #eg. "root"
declare password="" #eg. "xyz1123"
declare host="" #eg. "localhost"
declare db_name="" #eg. "dbname"
declare -i keep_days= #eg. 1
declare -i sleep_seconds= #eg. 2
declare date=$(date +"%F-%H-%M-%S")
declare -a tables_truncate_after_dump=() #Use it with caution array should be ("table1" "table2") no comma only whitespace in between

# Other options
echo "$(tput setaf 7)$(tput setab 4)"
echo "==========================================================" 
echo "# BEGINNING scheduled-automated-mariadb-mysql-backup.sh [$date]" 
echo "# DEVELOPED BY Vishal Vishwakarma <vishal@vishalvishwakarma.com>"
echo "# TOTAL OF 5 STEPS"

echo "1 - Creating $backup_path dir..."
sudo mkdir -p $backup_path
sudo chmod 757 $backup_path

# Dump database into SQL file and Coomprressing to bz2
echo "2 - Dumping $db_name database..."
sudo mysqldump --single-transaction --user=$user --password=$password --host=$host $db_name | bzip2 > $backup_path/$db_name-$date.sql.bz2
sleep $sleep_seconds

# Delete files older than $keep_days
echo "3 - Deleting backups older than $keep_days days."
sudo find $backup_path -name "*.sql.bz2" -mtime +$keep_days -exec rm {} \;

echo "4 - Truncating tables.."

sleep $sleep_seconds

for i in "${tables_truncate_after_dump[@]}"
do
   echo "     * Truncating table $db_name."$i""
   mysql -h $host -u $user --password=$password --database=$db_name -e "TRUNCATE TABLE $db_name."$i""
   sleep $sleep_seconds
done
echo "5 - DONE!"

echo "# ENDING scheduled-automated-mariadb-mysql-backup.sh"
echo "==========================================================" 
echo "$(tput sgr0)"








