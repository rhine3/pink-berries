# cerulean/

Within this folder are files pertaining to Cerulean hybrid assembly of the pink berry dataset. 

`cerulean_AMI_setup.ipynb`

`cerulean_AMI_setup2.ipynb`

Cerulean has lots of dependencies, so we made a machine image with Amazon Web Services to keep track of all these programs.
The "AMI_setup" files describe this challenging setup; I don't quite remember the difference between `cerulean_AMI_setup.ipynb` and
`cerulean_AMI_setup2.ipynb`. In the future, it would be nice to better organize an AMI, as all
programs are installed in the home directory. 


`jupyter_notebook_config.py`

This is the configuration file used to make Jupyter notebook functional on the AMI.


`bacteroidetes_hybrid_assembly.ipynb`

Two assembly attempts were made. A first attempt was with a subset of the metagenomic dataset, just binned to bacteroidetes. 
This was unsuccessful and abandoned. This file describes an attempt at a pipeline.


`proteorhodopsin_tree.ipynb`

A Jupyter notebook for a project related to the bacteroidetes assembly. 

After a few months of trying to let go of our frustrations, we attempted to assemble the entire metagenome.
