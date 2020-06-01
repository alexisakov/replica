% Housekeeping
clear;
close all;

% Create results directory
[~,~,~] = mkdir('reports');
[~,~,~] = mkdir('results');

%% Load model, solve it, etc.
m = model('bgpp2008.mod', 'Linear=', true);
setparam;

m = assign(m,par);
m = sstate(solve(m));


% Defining ranges
sfcast = qq(2019,1);
ehist     = sfcast-1;
shist     = ehist-20;
hrng      = shist:ehist;
efcast   = sfcast + 20;
frng      = sfcast:efcast;
prng      = sfcast-4:efcast;


% Display that the code is being processed
disp('Generating Impulse Response Functions...');

%% Generating IRFs for 1pp shocks from a given list
all_shock_list = get(m,'enames');
all_shock_name = get(m,'eDescript');

% Choose which shocks you want to simualte or if empty list, it takes all shocks
shock_list = {'epsilon2','epsilon1','epsilon4',...
              'epsilon3','eta1'}; 

% Assigns the names of the shocks (for report) (the order will be reshuffled!!)
ix = find(ismember(all_shock_list,shock_list));
shock_list = all_shock_list(ix);
shock_name = all_shock_name(ix);

%% Run IRFs and create report

rep = report.new('IRF Report - Deviations from steady-state',...
    'visible', false,'colsep',0.1);

for i = 1:numel(shock_list)
disp([shock_list{i}, ': ' shock_name{i},' ...']);

   d = zerodb(m,hrng);
   df = zerodb(m,shist:efcast);

   % Introducing a 1pp shock in period 'sfcast'
   d.(shock_list{i})(sfcast) = 1;
   
   % Simulate 
   s = simulate(m, d, frng,'deviation',true,'anticipate',false);
   s = dbextend(d,s);

% Plotting results
f = figure('visible','off');
subplot(231);
    plot(prng, [s.pi s.pi4 s.pi_tar],'linewidth',2);
    title('Inflation (pp, QoQ)');
    legend('qoq','yoy','target','Location','best');
    grid on;
subplot(232);
    plot(prng, [s.rs],'linewidth',2);
    title('Interest Rate (p.p.)');
    legend('Interest rate - Taylor rule','Location','best')
    grid on;
subplot(233);
    plot(prng, [s.y_gap],'linewidth',2);
    title('Demand');
    legend('Output Gap (%)','Location','best')
    grid on;
subplot(234);
    plot(prng, [s.rs-s.pi4{+4}, s.rr_M_eq-s.rho_M],'linewidth',2);
    title('RIR and trend'); 
    legend('RIR','RIR trend','Location','best')
    grid on;
subplot(235);
    plot(prng, [s.ls s.l_cpi],'linewidth',2);
    title('Nominal levels');
    legend('FX Rate','CPI','Location','best')
    grid on;
subplot(236);
    plot(prng, [s.lz s.lz_eq],'linewidth',2);
    legend('RER','REER','Location','best');
    title('RER and trend')
    grid on;

rep.userfigure(shock_name{i},f);
end

%% compile output
disp(['Generating report ...']);

rep.publish(strcat('./reports/impulse_responses.pdf'), 'display',false);

disp(['Done']);