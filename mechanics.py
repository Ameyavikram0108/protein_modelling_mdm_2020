"""
Created on Sun 23 Feb 2020

@author Nico Marrin

This module contains functions for exploring mechanical models of protein
dynamics.
"""

import csv

def get_label(rp,sim):
    """Gives the shortened filename for a given protein/simulation
    e.g. returns rp23_0045 for the 45th simulation of the 23rd protein.
    (this is essentially an adjusted verion of pdb_filename from the protein
    module) 
    """
    return r'rp{}_{:04}'.format(rp,sim)

# Create a dictionary of the energy data listed in energy_data.txt

energy_data = {}

with open('energydata.txt',newline='') as datafile:
    energy_data_reader = csv.reader(datafile,delimiter=' ')
    for row in energy_data_reader: 
        energy_data[row[0][:-4]] = float(row[2])

def get_energy(rp,sim): 
    """Returns the energy value for a given protein/simulation by retrieving it
    from the energy data dictionary."""
    return energy_data[get_label(rp,sim)]
