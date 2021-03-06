# A script which uses scipy's simple sum-of-squares minimisation to estimate
# the coefficients of the potential function given the energy data.

import numpy as np
import representations as rep
import mechanics as mc
import scipy.optimize as sop
import matplotlib.pyplot as plt
from scipy.stats.stats import pearsonr

rp = 42

E = np.array([mc.get_energy(rp,sim) for sim in range(1,101)])

P = np.array([rep.get_parameters(rp,sim,'CE') for sim in range(1,101)])

gamma = 2

def rho(K):
    """The function we want to minimize"""
    return sum(abs(E - (abs(P-np.mean(P,0))**gamma @ K[1:] + K[0]))**2)

N = len(P[0])

K0 = np.ones(N+1)

print(rho(K0))

Kopt = sop.minimize(rho,K0)['x']

print(Kopt)
print(rho(Kopt))

pm = np.mean(P,0)

def V(p,K):
    return abs(p-pm)**gamma @ K[1:] + K[0]

V_vals = [V(P[sim],Kopt) for sim in range(100)]

plt.scatter(E,V_vals)
xx = np.linspace(min(V_vals),max(V_vals),1000)
plt.plot(xx,xx,'--k')

# look into whether this is the right kind of correlation coefficient!
print('Correlation Coefficient =',pearsonr(E,V_vals)[0])

ax = plt.gca()
ax.set_aspect('equal')
plt.show()
