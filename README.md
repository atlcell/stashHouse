#StashHouse.sh
StashHouse.sh is a basic and simple script for automatically backing up websites and applications hosted on a 
Media Temple Dedicated Virtual (DV) server.

It is dependent upon the very good [s3sync](https://github.com/ms4720/s3sync) library.

At eyespeak, we use a custom and more detailed version that dumps our databases indivudally as we host *ALOT* of websites.

To install, you simply need to drag and drop the whole repo into your servers root, *NOT THE ROOT FOLDER*.

1. Change the Secret Key information located in /etc/s3conf/s3config.yml
2. Change the Bucket and Key to your own located on amazon s3

For more information and and more complexity, reference the s3sync documentation.
