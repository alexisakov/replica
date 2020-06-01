%% 2. Assign initial parameters: from bgpp and priors

par=struct();

% (1) 
par.alpha1 = 0.45; % BGPP
par.alpha2 = 0.45; % BGPP
par.alpha3 = 0.23; % BGPP
% (2)
par.beta1 = 0.5;% y_gap{+1} ~ beta(2,2)
par.beta2 = 0.3; % BGPP
par.beta3 = 0.1; % BGPP
par.beta4 = 0.2; % BGPP
par.beta5 = 0.5; %y_gap_f ~ beta(2,2)
% (3)
par.delta1 = 0.5; %ls{1} ~  beta(2,2)
% (4) Taylor rule
par.gamma1 = 0.4; %rs{-1} ~ BGPP 
par.gamma2 = 1.0;% (pi4_{+4}-pi_tar{+4} ~ gamma(1,1)
par.gamma3 = 1.0; % y_gap ~ gamma(1,1)
% Exogenous 
% (6) Equilibrium output growth:
par.chi = 0.5; % ~ beta(2,2)
par.y_eq_ss = 1.0 ; % ~ gamma(1,1)
% (7) Nominal interest rate on bank lending:
par.xi = 0.7; % rs_M{-1} ~ BGPP
% (8) Equilibrium nominal interest rate on bank lending
par.zeta2 = 0.5; % rr_M_eq{1} ~ beta(2,2)
par.rr_M_eq_ss = 1.0; % ~ gamma(1,1)
% (9) Term premium
par.kappa = 0.5 ; % ~ beta(2,2)
par.rho_M_ss = 1.0 ; % ~ gamma(1,1)
% (10) Equilibrium change of the real exchange rate:
par.zeta1 = 0.5; %*lz_eq_qq{-1} ~ beta(2,2) 
par.lz_eq_qq_ss = 1.0; % ~ gamma(1,1)
% (11) Risk premium:
par.zeta3 = 0.5 ; % rho{-1}  ~ beta(2,2) 
par.rho_ss = 1.0 ; % ~ gamma(1,1)

%% Load the model and assign the initial parameters
m = model('bgpp2008.mod','linear',true);

m = assign(m,par);

m = solve(m);
m = sstate(m);


%% Define estimation set

estim = struct();

betas = {'beta1','beta5','delta1','chi','zeta2','kappa','zeta1','zeta3'};

for bs = betas
    estim.(bs{1}) = {0.5, 0.001, 0.999, logdist.beta(2.,2.)};
end

gammas = {'gamma2','gamma3','y_eq_ss','rr_M_eq_ss','rho_M_ss','lz_eq_qq_ss','rho_ss'};

for gs = gammas
    estim.(gs{1}) = {1.0, 0.0001, 9.0, logdist.gamma(1.,1.)};
end

[parEst,pos,cov,Hess,mEst,V,Delta,PDelta] = estimate(m,qdb,qq(2008,1):qq(2018,4),estim,...
    'nosolution','penalty','filter',{'relative',false},'tolFun=',1e-8,'TolX=',1e-8);

[mfilt,filtdb] = filter(mEst,qdb,qq(2004,1):qq(2018,4));

%% IRF
s = srf(mfilt,12,'size=',1)

dbsave(s,'srfestimate.csv')