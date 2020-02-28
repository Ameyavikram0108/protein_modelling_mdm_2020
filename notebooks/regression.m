for i=0:9 
%% part for reading data
parameter_data='rp42params.csv';
energy_data='rp42energies.csv';
j=i*10+90;
if(j<=100)
x=csvread(parameter_data,i*10,0,[i*10,0,j-1,8]);
y=csvread(energy_data,i*10,0,[i*10,0,j-1,0]);
end

if(j>100)
    x_1=csvread(parameter_data,i*10,0,[i*10,0,99,8]);
    x_2=csvread(parameter_data,0,0,[0,0,(i-1)*10-1,8]);
    x=[x_1;x_2];
    y_1=csvread(energy_data,i*10,0,[i*10,0,99,0]);
    y_2=csvread(energy_data,0,0,[0,0,(i-1)*10-1,0]);
    y=[y_1;y_2];
end   

%% part for training data

%initial value of beta
beta0=[1,1,1,1,1,1,1,1,1];
average=mean(x,1);%equilibrium?
x=x-average;
 energy=inline('beta(1)*((x(:,1)).^2)+ beta(2)*((x(:,2)).^2)+beta(3)*((x(:,3)).^2)+ beta(4)*((x(:,4)).^2)+ beta(5)*((x(:,5)).^2)+ beta(6)*((x(:,6)).^2)+beta(7)*((x(:,7)).^2)+ beta(8)*((x(:,8)).^2)+beta(9)*((x(:,9)).^2);','beta','x')
%[beta,r=(y-myfunc(x)),j=jacobian]
[beta,r,j]=nlinfit(x,y,energy,beta0)

%beta is the parameter, r is the error, j is jocabian matrix.
%R is the sum of sqare of errors.
R=(r'*r)/90;
%% part for testing data
x1=csvread(parameter_data,90,0,[90,0,99,8]);
y1=csvread(energy_data,90,0,[90,0,99,0]);
x1=x1-average;
r_test=y1-energy1(beta,x1);
R_test=(r_test'*r_test)/10;
%R_test is the sum of sqare of test errors

%% save data in a matrix
Q(1,i+1)=R;
Q(2,i+1)=R_test;

i=i+1;
clearvars x y x1 y1 x_1 y_1 x_2 y_2;
end