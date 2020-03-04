# A script which uses scipy's nonlinear curve-fitting function to try and
# estimate the coefficients of the potential function given the energy data.

import numpy as np
import representations as rep
import mechanics as mc
import scipy.optimize as sop
import matplotlib.pyplot as plt
from scipy.stats.stats import pearsonr

rp = 42

E = np.array([mc.get_energy(rp,sim) for sim in range(1,101)])

P = np.array([rep.get_parameters(rp,sim,'CE') for sim in range(1,101)])

N = len(P[0])

def rho(Kg):
    """The function we want to minimize"""
    return sum(abs(E - (abs(P-np.mean(P,0))**Kg[N+1:] @ Kg[1:N+1] + Kg[0]))**2)


K0 = 2*np.ones(2*N+1)

print(rho(K0))

Kopt = sop.minimize(rho,K0)['x']

print(Kopt)
print(rho(Kopt))

pm = np.mean(P,0)

def V(p,K):
    return abs(p-pm)**K[N+1:] @ K[1:N+1] + K[0]

V_vals = [V(P[sim],Kopt) for sim in range(100)]

plt.scatter(E,V_vals)

print(pearsonr(E,V_vals))

ax = plt.gca()
ax.set_aspect('equal')
plt.show()
