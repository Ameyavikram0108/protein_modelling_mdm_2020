
# coding: utf-8

# # Exploring Representations
# 
# This tutorial shows how to use the various functions in ``representations.py`` to explore the data using three representations
# 
# * 'C': Using the centroids of each module
# * 'E': Using the endpoints of each module
# * 'CE': Using the centroids and endpoints of each module
# 

# In[2]:


import representations as rep
import protein as pt
import matplotlib.pyplot as plt


# First we can plot a few simulatios in each representation.

# In[3]:


rep.plotsim(24, 6, 'C')  # plot protein rp24, simulation 6 in representation 'C'


# In[4]:


rep.plotsim(324, 10, 'E')


# In[5]:


rep.plotsim(148, 3, 'CE')


# To explore joints use ``jointinfo``.

# In[6]:


joint1 = pt.randjoint()  # get a random joint
print(joint1)


# In[7]:


rep.jointinfo(joint1, 'CE')


# This joint appears once in the data, in rp550. The mean of the these parameters and the 5th and 95th percentiles are shown over all 100 simulations of the protein.

# In[8]:


rep.jointinfo('NcapD14 D14_j2_D54 D54_j1_D79', 'C')


# This joint appears in more proteins (we've used the 'C' representation this time). To get the combined data for a single parameter in the joint, use ``jointdistribution``.

# In[9]:


dist = rep.jointdistribution('NcapD14 D14_j2_D54 D54_j1_D79', 'Angle 1', 'C')
h1 = plt.hist(dist)
plt.xlabel('Angle 1 (radians)')


# To see which joints can combine to this one use ``nextjoints`` or ``randnextjoint`` for a random choice.

# In[11]:


pt.nextjoints('NcapD14 D14_j2_D54 D54_j1_D79')


# In[12]:


pt.randnextjoint('NcapD14 D14_j2_D54 D54_j1_D79')

