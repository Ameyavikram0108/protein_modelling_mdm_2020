% A matlab script for analysing the parameter/energy data for all simulations
% of protein 42

% Generate a 100 x 1 matrix with the energy values for each simulation:
energies = readmatrix('rp42energies.csv');

% Generate a 100 x 9 matrix with the parameter values for each simulation:
params = readmatrix('rp42params.csv');
% the parameters here are for the centroid representation (the most basic one)
% columns 1-4 are length values, columns 5-7 are the angles between segments,
% columns 8 and 9 are the dihedral angle values.
