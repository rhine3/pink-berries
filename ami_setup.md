# CeruleanTools AMI Setup

This is the setup that Lizzy Wilbanks and I used to create the CeruleanTools AMI. It may be incomplete. Compare with Lizzy's notes here: https://github.com/ewilbanks/micdiv2017/blob/master/research-proj/README.md if the tutorial doesn't seem to be working.

Wishlist for future versions:
* Clean up installation locations so that home directory isn't cluttered
* Need to add PBsuite install & test instructions
* Need to add .bashrc and jupyter config instructions

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

### Installing bioinformatics programs

Now we just need to install Cerulean and its dependencies. Its dependencies are specified on the Cerulean Sourceforge site (https://sourceforge.net/projects/ceruleanassembler/files/?source=navbar). Some dependencies listed on the site, like the Python libraries _numpy_ and _matplotlib_, should already be installed on the instance.

Run the following commands line-by-line, pressing y when prompted.

* PBJelly: https://sourceforge.net/projects/pb-jelly/ 

**Installing ABySS** 

Quite easy. Just follow the prompts:
``` 
sudo apt-get install abyss
```

**Install PBSuite**
NOTE: This last line MUST be run on Python 2.7, not Python 3. But I don't know what it does...
```
wget https://downloads.sourceforge.net/project/pb-jelly/PBSuite_15.8.24.tgz
tar -xvzf PBSuite_15.8.24.tgz
conda install -c anaconda networkx
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

## Getting dependencies working properly

**Editing the .bashrc file**

One thing you'll need is the PYTHONPATH environmental variable. Get the appropriate python libraries by running the following:

```
$ python
Python 2.7.13 |Anaconda 4.3.1 (64-bit)| (default, Dec 20 2016, 23:09:15)
[GCC 4.4.7 20120313 (Red Hat 4.4.7-1)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
Anaconda is brought to you by Continuum Analytics.
Please check out: http://continuum.io/thanks and https://anaconda.org
>>> import sys
>>> print sys.path
['', '/home/ubuntu/PBSuite_15.8.24', '/home/ubuntu/anaconda3/lib/python27.zip', '/home/ubuntu/anaconda3/lib/python2.7', '/home/ubuntu/anaconda3/lib/python2.7/plat-linux2', '/home/ubuntu/anaconda3/lib/python2.7/lib-tk', '/home/ubuntu/anaconda3/lib/python2.7/lib-old', '/home/ubuntu/anaconda3/lib/python2.7/lib-dynload', '/home/ubuntu/anaconda3/lib/python2.7/site-packages', '/home/ubuntu/anaconda3/lib/python2.7/site-packages/Sphinx-1.5.4-py2.7.egg', '/home/ubuntu/anaconda3/lib/python2.7/site-packages/setuptools-27.2.0-py2.7.egg', '/home/ubuntu/anaconda2/lib/python27.zip', '/home/ubuntu/anaconda2/lib/python2.7', '/home/ubuntu/anaconda2/lib/python2.7/plat-linux2', '/home/ubuntu/anaconda2/lib/python2.7/lib-tk', '/home/ubuntu/anaconda2/lib/python2.7/lib-old', '/home/ubuntu/anaconda2/lib/python2.7/lib-dynload', '/home/ubuntu/.local/lib/python2.7/site-packages', '/home/ubuntu/anaconda2/lib/python2.7/site-packages', '/home/ubuntu/anaconda2/lib/python2.7/site-packages/Sphinx-1.5.1-py2.7.egg', '/home/ubuntu/anaconda2/lib/python2.7/site-packages/setuptools-27.2.0-py2.7.egg']
>>> quit()

```
After `print sys.path` you'll get that array of files. Yours may look different. Edit it so that it has colons between the entries, like so:

```
/home/ubuntu/PBSuite_15.8.24:/home/ubuntu/anaconda3/lib/python27.zip:/home/ubuntu/anaconda3/lib/python2.7:/home/ubuntu/anaconda3/lib/python2.7/plat-linux2:/home/ubuntu/anaconda3/lib/python2.7/lib-tk:/home/ubuntu/anaconda3/lib/python2.7/lib-old:/home/ubuntu/anaconda3/lib/python2.7/lib-dynload
```


Add the following lines to your `~/.bashrc` file, using the text above.
```
#adding smrt analysis executables to path
export PATH="/opt/smrtanalysis/current/analysis/bin/:$PATH"

### pythonpath environmental variable
export PYTHONPATH="...OUTPUT FROM print sys.path GOES HERE"

# adding pbsuite executables to path
export PATH="$PATH:/home/ubuntu/PBSuite_15.8.24/bin"
export SWEETPATH=/home/ubuntu/PBSuite_15.8.24
```

