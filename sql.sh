# get a list of databases
databases=`$MYSQL --user=$USER --password=$PASSWORD \
 -e "SHOW DATABASES;"  | grep -v "Database"`

for db in $databases;
do
        /bin/echo $db >> /database
done
/bin/sed '/performance_schema/d;/information_schema/d;/apsc/d;/atmail/d;/horde/d;/phpmyadmin_EDcPoG8T70lv/d;/phpmyadmin_WwF_TkTdiQEN/d;/phpmyadmin__jYM0O2iM4_e/d;/phpmyadmin_dSPl3pAWpmRo/d;/psa/d;/sitebuilder5/d' /database > /database_new
/bin/cat /database_new | while read line; 
do
    /bin/echo "$line"
    $MYSQLDUMP --force --opt --user=$USER --password=$PASSWORD \
    --databases $line > "$OUTPUTDIR/$line'_'`/bin/date +%A_%m_%d_%Y-%H-%M`.sql"
done