
# coding: utf-8

# # Create a New Protein
# 
# This tutorial will show you how to make a new protein and explore its movement possibilities. It uses the 'CE' representation (see "Exploring Representations.ipynb"). We'll need the representations and protein modules. 

# In[16]:


import matplotlib.pyplot as plt
import representations as rep
import protein as pt


# We'll use a randomly generated new protein sequence of length 8 modules. Use ``randprotein`` to get this new sequence in a string.

# In[8]:


new_protein = pt.randprotein(8)
print(new_protein)


# To print all the information about this new protein use ``newprotein``. Each parameter is shown in a table, with the mean, range of movements, and the number of data points used to infer these quantities.

# In[9]:


rep.newprotein(new_protein)


# The plot shows the range of movements around each length with a cone. The data points for each parameter come from combining information from overlapping joints.
# 
# e.g. Joint 1: 'NcapD14 D14_j1_D18 D18_j1_D14' overlaps with Joint 2: 'D14_j1_D18 D18_j1_D14 D14_j2_D79'
# 
# There is information about the first length (between the endpoint and centroid) of the module D14_j1_D18 every time Joint 1 appears in the data. These data points are combined. There is also information about the same length in Joint 2, since the module overlaps. So these data points are also added to the data set. 
# 
# This parameter then appears as 'Length 3' in the table above, using 1500 data points to infer the mean and range. The range is calculated as the 5th and 95th percentiles of the combined data set to give an overall picture of the range of movement that excludes extreme values.

# ### Accessing the Data Points, Means and Ranges

# Use the functions ``newproteindistributions`` and ``newproteinranges`` to get data about the new protein.

# In[22]:


p1 = pt.randprotein(7)   # random protein of length 7
print(p1)

# We'll look at the distributions for these two parameters
print(rep.parameter_name(4,'CE',7))     # name of parameter in position 4, 'CE' representation, 7 module protein
print(rep.parameter_name(15,'CE',7))


# In[15]:


x = rep.newproteindistributions(p1)


# In[24]:


h1 = plt.hist(x[4])  # distribution of Length 5


# In[25]:


h2 = plt.hist(x[15]) # distribution of Angle 2


# In[31]:


# to get the means and ranges
means, fifths, ninetyfifths = rep.newproteinranges(p1)
print('\n'.join(str(x) for x in means))  # means of all parameters in a list

