#!/usr/bin/env bash

cd /tmp/
wget -c -O fits-0.6.2.zip http://projects.iq.harvard.edu/files/fits/files/fits-0.6.2.zip?m=1385738454
sudo yum install unzip
unzip -o fits-0.6.2.zip -d ~/
cd ~/
mv fits-0.6.2 fits
chmod a+x ~/fits/fits.sh

#Mark fits.sh as executable (chmod a+x fits.sh)
#Run "fits.sh -h" from the command line and see a help message to ensure FITS is properly installed
#Give your Sufia app access to FITS by:
#Adding the full fits.sh path to your PATH (e.g., in your .bash_profile), OR
#Changing config/initializers/sufia.rb to point to your FITS location: config.fits_path = "/<your full path>/fits.sh"

sudo yum -y install ImageMagick
