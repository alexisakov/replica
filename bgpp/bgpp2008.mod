%% replication of the Borodin-Gorbova-Plushevskaya-Plotnikov
% Legend 
% x_f - variable x for foreign sector
% x_qq - quarter on quarter change in the variable x
% x_eq - eqillibrium level of variable x
% x4 - year on year change in variable x (we would prefere the _yy notation, but it is only relevant for pi, so we keep the notation of the original note)

!transition_variables
'CPI, % QoQ AR' 					pi
'CPI, % YoY' 						pi4
pi_tar
pi_f
'CPI'                               l_cpi

ls
ls_qq 
ls_eq_2qq
lz
lz_eq
lz_eq_qq
lz_gap

y
y_eq
y_eq_qq
y_gap
y_f_gap

rs
rs_eq
rs_f
rr_f
rho
rr
rs_M
rr_M
rr_M_eq
rho_M

!parameters
alpha1
alpha2
alpha3
beta1
beta2
beta3
beta4
beta5
delta1
gamma1
gamma2
gamma3

chi
y_eq_ss
xi
zeta2
rr_M_eq_ss
kappa
rho_M_ss
zeta1
lz_eq_qq_ss
zeta3
rho_ss

!transition_shocks
'Supply shock' epsilon1
'Demand shock' epsilon2
'Exchange rate shock' epsilon3
'Policy shock' epsilon4

'Inflation target shock' eta1
eta2
eta3
eta4
eta5
eta6
eta7
eta8
eta9
eta10

!import(bgpp2008TransitionEndogenous.mod)
!import(bgpp2008TransitionExogenous.mod)
!import(bgpp2008TransitionIdentities.mod)

!measurement_variables
o_rs
o_rs_M 
o_rho
o_rs_f
o_pi 
o_pi_f
o_y
o_y_f_gap 
o_ls


!import(bgpp2008Measurement.mod)