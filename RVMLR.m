delimiterIn = ','; P = importdata('ProteinData.csv',delimiterIn) % Read in data
L = P.data(:,1:4); A = P.data(:,5:7); D = P.data(:,8:9); E = P.data(:,10); % Seperate data into L, A, & D

clf; figure(1); tiledlayout(3,1); nexttile;
plot(L,E,'.'); legend('L1','L2','L3','L4'); xlabel('Length'); ylabel('Energy'); nexttile; % Scatter plot of L
plot(A,E,'.'); legend('A1','A2','A3'); xlabel('Angle'); ylabel('Energy'); nexttile; % Scatter plot of A
plot(D,E,'.'); legend('D1','D2'); xlabel('Dihedral'); ylabel('Energy'); % Scatter plot of D

figure(2);
subplot(2,2,1); histogram(L(:,1)','FaceColor','b'); title('L1'); % Histogram of L1
subplot(2,2,2); histogram(L(:,2)','FaceColor','b'); title('L2'); % Histogram of L2
subplot(2,2,3); histogram(L(:,3)','FaceColor','b'); title('L3'); % Histogram of L3
subplot(2,2,4); histogram(L(:,4)','FaceColor','b'); title('L4'); % Histogram of L4
figure(3);
subplot(1,3,1); histogram(A(:,1)','FaceColor','r'); title('A1'); % Histogram of A1
subplot(1,3,2); histogram(A(:,2)','FaceColor','r'); title('A2'); % Histogram of A2
subplot(1,3,3); histogram(A(:,3)','FaceColor','r'); title('A3'); % Histogram of A3
figure(4);
subplot(1,2,1); histogram(D(:,1)','FaceColor','g'); title('D1'); % Histogram of D1
subplot(1,2,2); histogram(D(:,2)','FaceColor','g'); title('D2'); % Histogram of D2

[estimates,CI] = mle(L(:,1)); uL1 = estimates(1); oL1 = estimates(2); % mu & sigma estimates for normal distribution of L1
[estimates,CI] = mle(L(:,2)); uL2 = estimates(1); oL2 = estimates(2); % mu & sigma estimates for normal distribution of L2
[estimates,CI] = mle(L(:,3)); uL3 = estimates(1); oL3 = estimates(2); % mu & sigma estimates for normal distribution of L3
[estimates,CI] = mle(L(:,4)); uL4 = estimates(1); oL4 = estimates(2); % mu & sigma estimates for normal distribution of L4
[estimates,CI] = mle(A(:,1)); uA1 = estimates(1); oA1 = estimates(2); % mu & sigma estimates for normal distribution of A1
[estimates,CI] = mle(A(:,2)); uA2 = estimates(1); oA2 = estimates(2); % mu & sigma estimates for normal distribution of A2
[estimates,CI] = mle(A(:,3)); uA3 = estimates(1); oA3 = estimates(2); % mu & sigma estimates for normal distribution of A3
[estimates,CI] = mle(D(:,1)); uD1 = estimates(1); oD1 = estimates(2); % mu & sigma estimates for normal distribution of D1
[estimates,CI] = mle(D(:,2)); uD2 = estimates(1); oD2 = estimates(2); % mu & sigma estimates for normal distribution of D2

% LM fit w/ Gaussians of predictors L, A, & D
data = table(L(:,1),L(:,2),L(:,3),L(:,4),A(:,1),A(:,2),A(:,3),D(:,1),D(:,2),E,'VariableNames',{'L1','L2','L3','L4','A1','A2','A3','D1','D2','E'});
RVM = fitlm(data,'E~L1+L2+L3+L4+A1+A2+A3+D1+D2')
AIC_BIC_test = RVM.ModelCriterion


figure(5);
subplot(2,2,1); plotResiduals(RVM); % Distribution of residuals 
subplot(2,2,2); plotResiduals(RVM,'probability'); % Q-Q plot to check normality
subplot(2,2,3); plotResiduals(RVM,'fitted'); % Residuals vs. fitted values
subplot(2,2,4); plotResiduals(RVM,'lagged'); % Auto-correlation (via lagged residuals) 

corrcoef(L(:,1),L(:,2)); ccL1L2 = ans(1,2) % correlation coefficient b/w L1 & L2
corrcoef(L(:,1),L(:,3)); ccL1L3 = ans(1,2) % correlation coefficient b/w L1 & L3
corrcoef(L(:,1),L(:,4)); ccL1L4 = ans(1,2) % correlation coefficient b/w L1 & L4
corrcoef(L(:,1),A(:,1)); ccL1A1 = ans(1,2) % correlation coefficient b/w L1 & A1
corrcoef(L(:,1),A(:,2)); ccL1A2 = ans(1,2) % correlation coefficient b/w L1 & A2
corrcoef(L(:,1),A(:,3)); ccL1A3 = ans(1,2) % correlation coefficient b/w L1 & A3
corrcoef(L(:,1),D(:,1)); ccL1D1 = ans(1,2) % correlation coefficient b/w L1 & D1
corrcoef(L(:,1),D(:,2)); ccL1D2 = ans(1,2) % correlation coefficient b/w L1 & D2
corrcoef(L(:,2),L(:,3)); ccL2L3 = ans(1,2) % correlation coefficient b/w L2 & L3
corrcoef(L(:,2),L(:,4)); ccL2L4 = ans(1,2) % correlation coefficient b/w L2 & L4
corrcoef(L(:,2),A(:,1)); ccL2A1 = ans(1,2) % correlation coefficient b/w L2 & A1
corrcoef(L(:,2),A(:,2)); ccL2A2 = ans(1,2) % correlation coefficient b/w L2 & A2
corrcoef(L(:,2),A(:,3)); ccL2A3 = ans(1,2) % correlation coefficient b/w L2 & A3
corrcoef(L(:,2),D(:,1)); ccL2D1 = ans(1,2) % correlation coefficient b/w L2 & D1
corrcoef(L(:,2),D(:,2)); ccL2D2 = ans(1,2) % correlation coefficient b/w L2 & D2
corrcoef(L(:,3),L(:,4)); ccL3L4 = ans(1,2) % correlation coefficient b/w L3 & L4
corrcoef(L(:,3),A(:,1)); ccL3A1 = ans(1,2) % correlation coefficient b/w L3 & A1
corrcoef(L(:,3),A(:,2)); ccL3A2 = ans(1,2) % correlation coefficient b/w L3 & A2
corrcoef(L(:,3),A(:,3)); ccL3A3 = ans(1,2) % correlation coefficient b/w L3 & A3
corrcoef(L(:,3),D(:,1)); ccL3D1 = ans(1,2) % correlation coefficient b/w L3 & D1
corrcoef(L(:,3),D(:,2)); ccL3D2 = ans(1,2) % correlation coefficient b/w L3 & D2
corrcoef(L(:,4),A(:,1)); ccL4A1 = ans(1,2) % correlation coefficient b/w L4 & A1
corrcoef(L(:,4),A(:,2)); ccL4A2 = ans(1,2) % correlation coefficient b/w L4 & A2
corrcoef(L(:,4),A(:,3)); ccL4A3 = ans(1,2) % correlation coefficient b/w L4 & A3
corrcoef(L(:,4),D(:,1)); ccL4D1 = ans(1,2) % correlation coefficient b/w L4 & D1
corrcoef(L(:,4),D(:,2)); ccL4D2 = ans(1,2) % correlation coefficient b/w L4 & D2
corrcoef(A(:,1),A(:,2)); ccA1A2 = ans(1,2) % correlation coefficient b/w A1 & A2
corrcoef(A(:,1),A(:,3)); ccA1A3 = ans(1,2) % correlation coefficient b/w A1 & A3
corrcoef(A(:,1),D(:,1)); ccA1D1 = ans(1,2) % correlation coefficient b/w A1 & D1
corrcoef(A(:,1),D(:,2)); ccA1D2 = ans(1,2) % correlation coefficient b/w A1 & D2
corrcoef(A(:,2),A(:,3)); ccA2A3 = ans(1,2) % correlation coefficient b/w A2 & A3
corrcoef(A(:,2),D(:,1)); ccA2D1 = ans(1,2) % correlation coefficient b/w A2 & D1
corrcoef(A(:,2),D(:,2)); ccA2D2 = ans(1,2) % correlation coefficient b/w A2 & D2
corrcoef(A(:,3),D(:,1)); ccA3D1 = ans(1,2) % correlation coefficient b/w A3 & D1
corrcoef(A(:,3),D(:,2)); ccA3D2 = ans(1,2) % correlation coefficient b/w A3 & D2
corrcoef(D(:,1),D(:,2)); ccD1D2 = ans(1,2) % correlation coefficient b/w D1 & D2




















