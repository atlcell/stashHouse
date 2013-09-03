#For every directory in our cloned/work folder
for dir in ls -l $FILES_new;
	do
		#Change the directory to said folder
		cd $FILES_new/$dir 
			#Zip httpdocs to a new timestamped archive
			tar -zcvf $dir'_'`date +"%D"`.tar.gz httpdocs 
			#Ship That Directory to S3
			$s3cmd sync --acl-private --recursive  $dir'_'`date +"%D"`.tar.gz s3://server_bucket/$dir/ #Format would be server.domain.com/websitename.com on S3 buckets
		cd $FILES_new
	done
$rm -rf $FILES_new #Delete the work folder, clears space

	#Create a copy of every site in a new directory, 
	#during this process we can exclude sites we don't want
	#or need to back up. Including MediaTemple Linux folders
rsync "${SYNC_options[@]}" "$FILES_original" "$FILES_new" 
 