
format long
x=csvread('rp42params1.csv');
x1=x-mean(x,1);
x1_sin=sin(x1);
x1_cos=cos(x1);
x1_sq=x1.^2;
x1_cu=x1.^3;
x1_sqrt=(2*(x1>=0)-1).*abs(x1).^2.5;
f=sum(x1_sq(:,(11:19))',1)';

h=sum(x1_sq(:,[1:9])'+x1_sq(:,[2:10])',1)';

k=sum(x1_sin(:,[20:27])',1)';
y=csvread('rp42energies.csv');





X1=[f,h,k,ones(size(y))];
[b1,bint1,r1,rint1,stats1] = regress(y,X1);
plot(y,X1*b1,".");
hold on
t=linspace(-2840,-2780);
plot(t,t)
% (0.9006/81)/((1-0.9006)/18)
