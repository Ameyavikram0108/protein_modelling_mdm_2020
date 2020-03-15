# This script is to test a possible generalisation of the quadratic potential
# model - including higher order terms in the potential functions for each
# variable with unknown coefficients that are solved for via the least-squares
# method.

import numpy as np
import representations as rep
import mechanics as mc
import scipy.optimize as sop
import matplotlib.pyplot as plt
from scipy.stats.stats import pearsonr
import time

t0 = time.time()

rp = 1

print('protein number: ',rp)

E = np.array([mc.get_energy(rp,sim) for sim in range(1,101)])

P = np.array([rep.get_parameters(rp,sim,'CE') for sim in range(1,101)])

pm = np.mean(P,0)

N = len(P[0])

d = 4

def Vp(p,K,d):
    """A polynomial potential function of degree d with coefficients given by
    the vector K
    """
    return K[0] + sum(abs(p-pm)**gamma @ K[N*(gamma-2) + 1 : N*(gamma-1) + 1] for gamma in range(2,d+1))

def rho(K):
    """The sum of squared errors across all simulations
    (which we attempt to minimize)
    """
    return sum((E[sim] - Vp(P[sim],K,d))**2 for sim in range(100))



K0 = np.ones((d-1)*N + 1)

Kopt = sop.minimize(rho,K0)['x']

print('Optimized coefficients:')
print(Kopt)

print('Total error squared after optimization = ',rho(Kopt))

V_vals = [Vp(P[sim],Kopt,d) for sim in range(100)]

plt.scatter(E,V_vals)
xx = np.linspace(min(V_vals),max(V_vals),1000)
plt.plot(xx,xx,'--k')

# look into whether this is the right kind of correlation coefficient!
print('Correlation Coefficient =',pearsonr(E,V_vals)[0])

ax = plt.gca()
ax.set_aspect('equal')

tf = time.time()
print('time taken for computation = ', tf-t0, 'seconds')

plt.show()
