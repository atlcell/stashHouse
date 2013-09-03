# Variables

#	Binaries
	date="/bin/date"
	rm="/bin/rm"
	ls="/bin/ls"
	s3cmd="/s3sync/s3cmd.rb"
	
#	Files
	FILES_original="/var/www/vhosts\r"
	FILES_new="/var/www/marcell\r"
	SYNC_options=(
	-av
    --recursive
    --progress
    --delete
    --exclude-from='exclude.txt'
	)