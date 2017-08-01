# Metagenome Hybrid Assembly with Cerulean
by Tessa Rhinehart (contact: tessa.rhinehart at gmail dot com)

This notebook walks through the steps used to create a metagenomic assembly using Cerulean software loaded on an 
Amazon Web Services machine image (AMI).


# Getting started
Use the CeruleanTools AMI and attach the Pink Berries data volume. When your instance boots up, mount the volume, e.g.
```
mkdir ~/data
sudo mount /dev/xvdf/ ~/data
```

