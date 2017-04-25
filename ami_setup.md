# CeruleanTools AMI Setup

This is the setup that Lizzy Wilbanks and I used to create the CeruleanTools AMI. It may be incomplete. Compare with Lizzy's notes here: https://github.com/ewilbanks/micdiv2017/blob/master/research-proj/README.md if the tutorial doesn't seem to be working.

Wishlist for future versions:
* Clean up installation locations so that home directory isn't cluttered

### Starting up your EC2 instance

First, start an Amazon Web Services instance (m3.2xlarge) on the SMRT community AMI provided by PacBio. We need the SMRT tools because we need to use BLASR, but installing BLASR on its own is a pain in the neck. We need two security rules when running these two things: 8888, for Jupyter notebooks, and 8080, for running the SMRT portal.

**Upgrading the system**

Unfortunately, the PacBio AMI runs on the Lucid version of Linux (release 12). We need it to run on Precise (release 16), a more updated version. We'll have to update the whole shabang, taking it from 12 to 14 and from 14 to 16. Run the following line-by-line:
 
```
sudo apt-get update
do-release-upgrade
sudo apt-get install -o APT::Immediate-Configure=false -f apt python-minimal
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install default-jre

```

Now, run ```lsb_release -a``` to see what release you're running on. It should be Precise.

### Installing prerequisite programs 

**Installing Github**

This will install Github and get you the necessary file (the configuration file for jupyter to work)

```
sudo apt-get install git
git clone https://github.com/rhine3/MicDivProject.git
```

**Installing and setting up Jupyter**

Jupyter notebook is a common way of creating bioinformatics pipelines. It is included in the Anaconda package. Install Anaconda using the following commands, typing "yes" when prompted.

```
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
bash Anaconda3-4.3.1-Linux-x86_64.sh
```

To make a secure connection between our notebook, we'll have to set up a password and a key/certification.

* Generate key and certification:
```
cd /home/ubuntu/.jupyter
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem
```

* Generate password:
```
#Note: if you run this command in an unsecured Jupyter notebook, 
#      YOUR PASSWORD WILL NOT BE SECURE

from IPython.lib import passwd
password = passwd("your_pass_here")
password
```

Use your favorite text editor to add your password to the jupyter notebook config file. 
Then, move that file to whereever it ought to be. :P

### Installing dependencies

Now we're really ready to rock and roll... at installing the dependencies of Cerulean. These are specified on the Cerulean Sourceforge site (https://sourceforge.net/projects/ceruleanassembler/files/?source=navbar). 

Since the dependency installations require some interactivity, they can't be run from this notebook. Instead, make sure you're in your home folder and run the following commands line-by-line, pressing y when prompted. (Some dependencies listed on the site, like the Python libraries _numpy_ and _matplotlib_, should already be installed on the instance.)

* PBJelly: https://sourceforge.net/projects/pb-jelly/ 

**Installing ABySS** 

Quite easy. Just follow the prompts:
``` 
sudo apt-get install abyss
```

**Installing Cerulean**

Now that the dependencies are installed, download the Cerulean tarball itself and extract the files, then delete the tarball. The flags used for tar decompression below are:

* x - e[x]tract files (not compress)
* v - [v]erbose (tells you what files are being extracted)
* f - [f]ile (tells you that the tarball filename is about to follow)

```
!wget "https://downloads.sourceforge.net/project/ceruleanassembler/Cerulean_v_0_1.tar.gz"
!tar -xvf Cerulean_v_0_1.tar.gz
!rm Cerulean_v_0_1.tar.gz
```
