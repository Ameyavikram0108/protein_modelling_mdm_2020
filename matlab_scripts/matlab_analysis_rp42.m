% A matlab script for analysing the parameter/energy data for all simulations
% of protein 42

clear

% Generate a 100 x 1 matrix with the energy values for each simulation:
energies = readmatrix('rp42energies.csv');

% Generate a 100 x 9 matrix with the parameter values for each simulation:
params = readmatrix('rp42params.csv');
% the parameters here are for the centroid representation (the most basic one)
% columns 1-4 are length values, columns 5-7 are the angles between segments,
% columns 8 and 9 are the dihedral angle values.

% Plot a histogram of the energies:
figure(1)
clf
hold on

edges = min(energies):2:max(energies);
histogram(energies,edges)
title('histogram of energy values')

% Histograms of some parameter values:
figure(2)
clf
hold on

histogram(params(:,6));
xline(mean(params(:,6)),'--r','linewidth',2);
title('histogram of one of the parameter values')

% Mean (equlibrium?) values for each parameter:

meanparams = mean(params,1);

% Trying out a (very!) basic quadratic potential function:
V1 = @(sim) sum((params(sim)-meanparams).^2);

energies1 = zeros(100,1);

for n = 1:100
	energies1(n) = V1(n);
end

figure(3)
clf
hold on
scatter(energies,energies1,'xk');
R = corr(energies,energies1)
title('comparing actual energy values with estimated values')
xlabel('actual energy values')
ylabel('estimated energy values')

