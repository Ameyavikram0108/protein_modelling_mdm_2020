# Script for generating .csv files containing energy and paramter data for the
# simulations of a given protein for analysis in non-python tools
# (matlab/excel/?)

import numpy as np
import representations as rps
import mechanics as mc

# Choose protein number by editing this line:
rp = 42 

# Choose representation type by editing this line:
# (default 'CE' = centroid-endpoint representation)
rep = 'CE'

enfilename = 'rp' + str(rp) + 'energies.csv'
paramfilename = 'rp' + str(rp) + 'params.csv'

with open(enfilename,'w+') as enfile:
    for sim in range(1,101):
        enfile.write(str(mc.get_energy(rp,sim)) + '\n')

with open(paramfilename,'w+') as paramfile:
    for sim in range(1,101):
        paramfile.write(str(list(rps.get_parameters(rp,sim,rep=rep)))[1:-1] + '\n')
