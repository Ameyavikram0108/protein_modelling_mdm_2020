% Regression script for the elastic network model

E = csvread('rp42energies.csv');

P = csvread('rp42_ENM_params.csv');

n = length(E);

Pbar = mean(P,1);

dP = P - Pbar;

X = [ones(n,1) dP.^2];

[b,bint,r,rint,stats] = regress(E,X);

% Print the calculated coefficients:
b'

p = length(b);

% Print the calculated statistics 
% (R^2, F-statistic, p-value, estimated error, variance)
stats

R2 = stats(1);

% The adjusted R^2 statistic:
Rbar2 = 1 - (1-R2)*(n-1)/(n - p -1)

figure(1);
scatter(X*b,E);
