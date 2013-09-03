rsync -av --progress --exclude-from '/exclude-list.txt' /var/www/vhosts/ /var/www/backup_vhosts/
for dir in `/bin/ls /var/www/backup_vhosts/`;
do
        cd /var/www/backup_vhosts/$dir
                tar -zcvf $dir'_'`/bin/date +%A_%m_%d_%Y-%H-%M`.tar.gz httpdocs
                s3cmd sync --acl-private --recursive  $dir'_'`/bin/date +%A_%m_%d_%Y-%H-%M`.tar.gz s3://weekly_domain.com/$dir/
        cd /var/www/backup_vhosts
done
/bin/echo 
/bin/rm -rf /var/www/backup_vhosts

/bin/echo "Weekly file success!"`date` >> /s3log

mkdir /var/www/backup_sql
USER="usernamesql"
PASSWORD="pass"
OUTPUTDIR="/var/www/backup_sql"
MYSQLDUMP="/usr/bin/mysqldump"
MYSQL="/usr/bin/mysql"

# get a list of databases
databases=`$MYSQL --user=$USER --password=$PASSWORD \
 -e "SHOW DATABASES;"  | grep -v "Database"`

for db in $databases;
do
        /bin/echo $db >> /database
done
/bin/sed '/jesus/d' /database > /database_new
/bin/cat /database_new | while read line; 
do
    /bin/echo "$line"
    $MYSQLDUMP --force --opt --user=$USER --password=$PASSWORD \
    --databases $line > "$OUTPUTDIR/$line'_'`/bin/date +%A_%m_%d_%Y-%H-%M`.sql"
done

s3cmd sync --acl-private --recursive /var/www/backup_sql/ s3://weekly_domain.com/SQL/
/bin/echo 
/bin/rm -rf /var/www/backup_sql
/bin/rm -rf /database_new
/bin/rm -rf /database

/bin/echo "Weekly SQL success!"` date` >> /s3log
/bin/echo "Weekly cron success!"` date` >> /s3log


