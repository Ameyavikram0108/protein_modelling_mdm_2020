 %the loop is for k-fold volidation (divide the 100 data points into 10 sets,
 %For each loop, take 9 sets as training data points to do regression and 1
 %set as testing data points to test the function we get from regression.
 %in other words, we take 90 data points as training data points and 10
 %data points as testing data points in each loop.
for i=0:9
%% part for reading data
parameter_data='rp42params.csv';%rename for parameter file.csv
energy_data='rp42energies.csv';%rename for energy file.csv
%j1 would be used for importing data(notice the value of j1) 
j1=i*10+90;
% Firstly, note that in the code, the data points is from number 0 to
% number 99.
% In this situation,i=0 or i=1.For each 'i', we read the corresponding
%training data points which would be  number 0-89, 10-99 respectively. 
%read parameter data in x, and energy data in y.
%the function form is like:
%csvread(File name,# Initial raw, # Initial column,[#initial raw,#initial
%column, #end raw, #end column])
if(j1<=100)    
x=csvread(parameter_data,i*10,0,[i*10,0,j1-1,8]);
y=csvread(energy_data,i*10,0,[i*10,0,j1-1,0]);
end
% in this situation i is from 2 to 9. We read the data points into two matrix
%(e.g. x_1 and x_2), and combine two matrix into one. After combination,
%the number of data points (both for x and y) should be 90.
% x_1, x_2 is for parameter data, y_1, y_2 is for energy data.
% function form is the same as above one.
if(j1>100)
    x_1=csvread(parameter_data,i*10,0,[i*10,0,99,8]);
    x_2=csvread(parameter_data,0,0,[0,0,(i-1)*10-1,8]);
    x=[x_1;x_2];
    y_1=csvread(energy_data,i*10,0,[i*10,0,99,0]);
    y_2=csvread(energy_data,0,0,[0,0,(i-1)*10-1,0]);
    y=[y_1;y_2];
end   

%% part for training data

%initial value of the coefficient vector( which is called 'beta')
beta0=[1,1,1,1,1,1,1,1,1,1400];
%this code is to calculate the average values(equilibrium) for each parameters of
%training data.
average=mean(x,1);
%here we define (p-p*) as a new variable for each parameter ( so in this code, the parameter data
%matrix for p change to the "deviation matrix" for ¦¤p£©
x=x-average;
%Here the energy function is :
%energy=¦²(beta(i)*(¦¤p(i))^2)
%here we use inline function which would be used for 'nlinfit' method:
%the form of inline function:
%inline('function', 'coefficient matrix','variable matrix')
% (note: in this case, you can put any function in it, not only the
% quaduatic form)
 energy=inline('beta(1)*((x(:,1)).^2)+ beta(2)*((x(:,2)).^2)+beta(3)*((x(:,3)).^2)+ beta(4)*((x(:,4)).^2)+ beta(5)*((x(:,5)).^2)+ beta(6)*((x(:,6)).^2)+beta(7)*((x(:,7)).^2)+ beta(8)*((x(:,8)).^2)+beta(9)*((x(:,9)).^2)+beta(10);','beta','x')
%in this code, we use nlinfit method to do regression.( 'nlinfit' is a
%method which use least square method to adjust the coefficient to do
%regression.)
%The form of the function:
%[coefficient vector,error of model, jocabian matrix for model)
[beta,r,j]=nlinfit(x,y,energy,beta0)
%R is the average of the sum of sqare of model errors:£¨1/n£©¦²e?
R=(r'*r)/90;
%% part for testing data
% part for reading testing data:
% in this part, remember after we taking 90 of 100 data points as training 
% data, the rest of data points (10 data points) would always be testing
% data points.
% the form of function has shown at the begining.
if(j1<99)
x1=csvread(parameter_data,j1,0,[j1,0,99,8]);
y1=csvread(energy_data,j1,0,[j1,0,99,0]);
end
if(j1>99)
    x1=csvread(parameter_data,(i-1)*10,0,[(i-1)*10,0,(i-1)*10+9,8]);
    y1=csvread(energy_data,(i-1)*10,0,[(i-1)*10,0,(i-1)*10+9,0]);
end
% again, transfer parameter matrix to corresponding 'deviation matrix'    
x1=x1-average;
%r_test: the error of test data( real test energy points- test energy points
%by function)
%R_test: the average of sum of sqare of test errors:£¨1/n£©¦²e?
%(Note: 'energy1',which is saved as energy1.m, is the same function as
%energy, but in different form, set this energy1.m is convinient for us to
%input the parameter data and output the energy data corresponding to
%function directly.)
%The way to use it:energy_databyfunction=energy1(coefficient,variable)
r_test=y1-energy1(beta,x1);
R_test=(r_test'*r_test)/10;


%% save data in a matrix
%for each loop, we have a specific R and R_test. we want to save this two
%data in a matrix.(if you can want to add more element this to a matrix, just do it like
%Q(3,i+1)=something, this means save the data in the third line)
Q(1,i+1)=R;
Q(2,i+1)=R_test;

i=i+1;
% we have to delete this variables in workspace for each loop, otherwise this will cause errors 
clearvars x y x1 y1 x_1 y_1 x_2 y_2;
end
