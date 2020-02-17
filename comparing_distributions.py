
# coding: utf-8

# # Compare Distributions
# 
# Since data has been combined from different distributions when creating new protein sequences, it is useful to compare them. The module ``distributions`` allows you to do this.

# In[1]:


import representations as rep
import distributions as dist


# In[3]:


# get the distribution of length 8 in proteins containing the ending joint 'D14_j2_D14 D14_j1_D81 CcapD81'

x = rep.jointdistribution('D14_j2_D14 D14_j1_D81 CcapD81', 'Length 8') 


# In[5]:


# calculate the KL divergence matrix and plot the Kernel Density estimates of all distributions
M = dist.divergence_matrix(x)


# In[6]:


# Do the same but use the Jensen-Shannon divergence
M = dist.divergence_matrix(x, method='JS')

