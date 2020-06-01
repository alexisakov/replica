!transition_equations
% Phillips curve:
pi = alpha1*pi4{+4} + alpha2*pi4{-1} + (1-alpha1-alpha2)*(ls_qq + pi_f - lz_eq_qq) + alpha3*y_gap + epsilon1; % (1)
% IS curve:
y_gap = beta1*y_gap{+1} + beta2*y_gap{-1} - beta3*(rr_M{-1} - rr_M_eq{-1}) + beta4*lz_gap{-1} + beta5*y_f_gap + epsilon2; % (2)
% UIP:
ls = delta1*ls{1} + (1-delta1)*(ls{-1} + ls_eq_2qq/4) - (rs - rs_f - rho)/4 + epsilon3; % (3)
% Taylor rule:
rs = gamma1*rs{-1} + (1-gamma1)*(rs_eq + gamma2*(pi4{+4}-pi_tar{+4}) + gamma3*y_gap) + epsilon4; % (4)