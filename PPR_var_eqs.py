# This script is to test a possible generalisation of the quadratic potential
# model - including higher order terms in the potential functions for each
# variable with unknown coefficients that are solved for via the least-squares
# method.

import numpy as np
import representations as rep
import mechanics as mc
import scipy.optimize as sop
import matplotlib.pyplot as plt
from scipy import stats
import time

t0 = time.time()

rp = 42

print('protein number: ',rp)

E = np.array([mc.get_energy(rp,sim) for sim in range(1,101)])

P = np.array([rep.get_parameters(rp,sim,'CE') for sim in range(1,101)])

pm = np.mean(P,0)

N = len(P[0])

d = 4
print('highest order of terms in polynomials:',d)

def Vp(p,K,d):
    """A polynomial potential function of degree d with coefficients given by
    the vector K
    """
    return (K[0] + sum(abs(p-K[1:N+1])**gamma @ K[N*(gamma-1) + 1 : N*gamma +
        1] for gamma in range(2,d+1)) )

def rho(K):
    """The sum of squared errors across all simulations
    (which we attempt to minimize)
    """
    return sum(abs(E[sim] - Vp(P[sim],K,d))**2 for sim in range(100))


K0 = np.ones(d*N + 1)
K0[0] = -2000
K0[1:N+1] = pm

Kopt = sop.minimize(rho,K0)['x']

print('Optimized coefficients:')
print(Kopt)

print('Parameter means')
print(pm)

print('Differences between parameter means and calculated equilibria:')
print(Kopt[1:N+1]-pm)

print('Total error squared after optimization = ',rho(Kopt))

V_vals = [Vp(P[sim],Kopt,d) for sim in range(100)]
R2 = stats.linregress(E,V_vals)[2]**2
print('R^2  =',R2)

ax = (plt.figure()).add_axes([.1,.1,.8,.8])
ax.scatter(E,V_vals)
xx = np.linspace(min(V_vals),max(V_vals),1000)
ax.plot(xx,xx,'--k')
ax.set_xlabel("$E(\mathbf{p})$")
ax.set_ylabel("$V(\mathbf{p})$")
ax.set_title("""Scatter plot of predicted energy values against measured energy
        values - Order {} Polynomial Model for Protein {} R^2 =
        {:.3f}""".format(d,rp,R2))


ax = plt.gca()
ax.set_aspect('equal')

tf = time.time()
print('time taken for computation = ', tf-t0, 'seconds')

plt.show()
