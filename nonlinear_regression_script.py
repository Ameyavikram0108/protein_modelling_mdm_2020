# A script which uses scipy's nonlinear curve-fitting function to try and
# estimate the coefficients of the potential function given the energy data.

import numpy as np
import representations as rep
import mechanics as mc
import scipy.optimize as sop

rp = 42

E = np.array([mc.get_energy(rp,sim) for sim in range(1,101)])

P = np.array([rep.get_parameters(rp,sim,'C') for sim in range(1,101)])

def rho(K):
    """The function we want to minimize"""
    return sum(E - ((P-np.mean(P,0))**2 @ K[1:] + K[0])**2)

K0 = np.ones(10)

print(rho(K0))

Kopt = sop.minimize(rho,K0)['x']

print(rho(Kopt))


