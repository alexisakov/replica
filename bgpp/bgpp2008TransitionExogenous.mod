!transition_equations
% Inflation target:
pi_tar = pi_tar{-1} + eta1; % (5)
% Equilibrium output growth:
y_eq_qq = chi*y_eq_qq{-1} + (1-chi)*y_eq_ss + eta2; % (6)
% Nominal interest rate on bank lending:
rs_M  = xi*rs_M{-1} + (1-xi)*((rs+rs{+1}+rs{+2}+rs{+3})/4+rho_M) + eta3; % (7)
% Equilibrium nominal interest rate on bank lending
rr_M_eq = zeta2*rr_M_eq{-1} + (1-zeta2)*rr_M_eq_ss + eta4; % (8)
% Term premium
rho_M = kappa*rho_M{-1} + (1-kappa)*rho_M_ss + eta5; % (9)
% Equilibrium change of the real exchange rate:
lz_eq_qq = zeta1*lz_eq_qq{-1} + (1-zeta1)*lz_eq_qq_ss + eta6; % (10)
% Risk premium:
rho = zeta3*rho{-1} + (1-zeta3)*rho_ss + eta7; % (11)
% Foreign output gap
y_f_gap = 0.85*y_f_gap{-1} + eta8; % (12)
% Foreign interest rate
rs_f = 0.85*rs_f{-1} + eta9; % (13)
% Foreign inflation
pi_f = 0.85*pi_f{-1} + eta10; % (14)