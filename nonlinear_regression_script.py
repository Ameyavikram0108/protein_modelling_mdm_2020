# A script which uses scipy's nonlinear curve-fitting function to try and
# estimate the coefficients of the potential function given the energy data.

import numpy as np
import representations as rep
import mechanics as mc

rp = 42

E = np.array([mc.get_energy(rp,sim) for sim in range(1,101)])

P = np.array([rep.get_parameters(rp,sim) for sim in range(1,101)])

