# tse-packer-templates

##What this is
This repository contains the build tools and scripts you need to create a Windows 2012 R2 image for your TSE demo environment. Feel free to contribute/make fixes it is by no means perfect.

####Credit
Most of the stuff in here came from https://github.com/joefitzgerald/packer-windows/tree/master/scripts
Some stuff has been stripped out, but the codebase is from the above link

###Pre-requisites
1. First you need to install packer
1. brew install packer
1. verify you have the right package installed
2. type packer on your command line and you should see this:
1. usage: packer [--version] [--help] <command> [<args>] ...etc
2. Now you need to get yourself a windows 2012 R2 ISO.
3. Our iso is in the S3 bucket, check confluence on where to get it



###Setting up a packer template to build the image from the ISO
1. Set up a working directory and check out this repo to get the files you need.
2. Put your Win2012 ISO in that same directory.
3. Explanation of the files and what they do:
1. autounattend.xml (this is your automated installer for windows)
2. windows2012_r2.json (this is the packer build file)
3. scripts directory (all the install scripts and miscellaneous stuff goes in here)


###Building the image
Run the following commands.


1. packer validate windows2012_r2.json
2. packer build -force windows2012_r2.json

This should just work and produce a box file, you can then create a vagrant test area with vagrant init and add this to the vagrant file
```
config.vm.box = "pathToBoxFile"
config.vm.communicator = "winrm"
config.winrm.username = "vagrant"
config.winrm.password = "vagrant"
config.vm.network "forwarded_port", host: 33389, guest: 3389
```


You can then connect to the host with vagrant rdp <boxname>, username and password is vagrant.



###So you want to build your own image
If you are interested in what the files are and how to debug and work with packer you can get it all from here: https://www.packer.io/docs

Start with templates/builders/provisioners and then read the debug section.

Its painful but you should do it before you mess with these files. Also it makes no sense for me to repeat the information already contained in the docs in this readme.
