x=csvread('rp42params.csv');
x=x-mean(x,1);
y=csvread('rp42energies.csv');
x1=x.^2;
x2=x.^3;
x3=x.^4;
X1=[ones(size(y)),x1,x2,x3];
[b1,bint1,r1,rint1,stats1] = regress(y,X1);
scatter(y,X1*b1);
hold on
t=linspace(-2840,-2780);
plot(t,t)

