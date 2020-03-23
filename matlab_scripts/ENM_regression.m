% Regression script for the elastic network model

E = csvread('rp42energies.csv');

P = csvread('rp42params.csv');

Pbar = mean(P,1);

Q = (P - Pbar).^2;

X = [ones(length(E),1) Q];

[b,bint,r,rint,stats] = regress(E,X);

% Print the calculated coefficients:
b'

% Print the calculated statistics (R^2, F-statistic, p-value, estimated error
% variance)
stats

R2 = stats(1);

% The adjusted R^2 statistic:
Rbar2 = 1 - (1-R2)*(length(E)-1)/(length(E) - length(b) -1)

scatter(X*b,E)
