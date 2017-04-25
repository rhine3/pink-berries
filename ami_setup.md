This tutorial is a bit funny, because it includes the installation of Jupyter Notebook while being written in a Jupyter notebook. Oh well. :)

It may also be an incomplete tutorial. Compare with Lizzy's notes here: https://github.com/ewilbanks/micdiv2017/blob/master/research-proj/README.md if the tutorial doesn't seem to be working.

**Starting up EC2 Instance**

First, start an Amazon Web Services instance (m3.2xlarge) on the SMRT community AMI provided by PacBio. We need the SMRT tools because we need to use BLASR, but installing BLASR on its own is pretty hard. We need two security rules when running these two things: 8888, for JuPyter notebooks, and 8080, for running the SMRT portal.

**Upgrading the System**

Unfortunately, the PacBio AMI is running on the Lucid version of Linux. We need it to run on Precise, a more updated version. We'll have to update the whole shabang. Run the following line-by-line:
 
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

