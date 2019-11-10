# MySQL MariaDB Backup Script
A bash script to be implemented as a cron job to backup your MySQL or MariaDB database.
It compresses the backup simultaneously to bz2

# Usage
First of all open the file and config:

backup_path="/var/www/mysql-backups"<br/>

user="YOUR DB USER"<br/>

password="YOUR DB PASSWORD"<br/>

host="YOUR HOST ADDRESS"<br/>

db_name="YOUR DB NAME"<br/>

keep_days= #eg. 1
* keep_days is the amount of days that the script will keep files. (Default last 3 days files)

tables_truncate_after_dump
* It's an array of tables that will be truncated after the dump. Can be used if you want to truncate a log table. Do not split with comma use only white space. Example tables_truncate_after_dump("table1" "table2")

# Add Permission
Be sure to give the correct permission to execute the bash with:

```bash
sudo chmod 700 /path/to/scheduled-automated-mariadb-mysql-backup.sh
```

# Add Bash as Cron Job
```bash
sudo crontab -e
//Add this in the end of file
00 20 * * * /path/to/scheduled-automated-mariadb-mysql-backup.sh
```
In this case it’ll run every day at 8 PM.

# Questions?
Vishal Vishwakarma <visha@vishalvishwakarma.com>