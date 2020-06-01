!transition_equations
% Annual inflation
pi4 = (pi + pi{-1} + pi{-2} + pi{-3}) / 4; % (15)
% Level of output
y = y_eq + y_gap; % (16)
% Equilibrium output
y_eq = y_eq{-1} + y_eq_qq/4; % (17)
% Nominal neutral policy rate
rs_eq = rr_M_eq - rho_M + pi4{+4}; % (18)
% Real neutral policy rate
rr = rs - pi{+1}; % (19)
% Real bank interest rate:
rr_M = rs_M - pi4{+4}; % (20)
% Nominal exchange rate change:
ls_qq = 4*(ls - ls{-1}); % (21)
% Equilibrium exchange rate change over two quarters:
ls_eq_2qq = pi - pi{+1} - pi_f - pi_f{+1} + 2*lz_eq_qq; % (22)
% Real exchange rate:
lz = lz{-1} + (ls_qq - pi + pi_f)/4; % (23)
% Equilibrium real exchange rate level:
lz_eq = lz_eq{-1} + lz_eq_qq/4; % (24)
% Real exchange rate gap: 
lz_gap = lz - lz_eq; % (25)
% Foreign real interest rate:
rr_f = rs_f - pi_f{+1}; % (26)

l_cpi = l_cpi{-1}+pi/4;






