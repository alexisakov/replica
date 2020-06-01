m = model('bgpp2008.mod', 'Linear=', true);
setparam;

m = assign(m,par);
m = sstate(solve(m));

a01preparedata;

[mfilt,filtdb] = filter(m,qdb,qq(2000,1):qq(2010,4)) ;

contrib = simulate(mfilt,filtdb,qq(2000,1):qq(2010,4),'contributions=',true);

histdecVarList = {'pi', 'ls', 'y', 'rs', 'rho', 'rs_M'};

rep = report.new('Historical shock decomposition report', 'visible', false,'colsep',0.1);

f = figure('visible','off');

map = [0.2 0.1 0.5
    0.1 0.5 0.8
    0.2 0.7 0.6
    0.8 0.7 0.3
    0.9 1 0
    1 1 0
    1 0 1
    0 1 1
    1 0 0
    0 1 0
    0 0 1
    0.3 0.7 0.8
     0.3 0.0 0.8
      0.3 0.8 0.0
      0.0 0.3 0.8
      0.1 1 0.9
    ];


subplot(231);
    b = barcon(contrib.pi,'colorMap=',map);
    title('Inflation (pp, QoQ SA)');
    legend('supply shock','demand shock','FX shock','monetary policy shock','target shock','Location','best');
    grid on;

subplot(232);
    b = barcon(contrib.ls_qq,'colorMap=',map);
    title('Exchange rate, % QoQ');
    grid on;
    
    
subplot(233);
    b = barcon(contrib.y_gap,'colorMap=',map);
    title('Output gap');
    grid on;
    
subplot(234);
    b = barcon(contrib.rs,'colorMap=',map);
    title('Policy rate');
    grid on;
    
subplot(235);
    b = barcon(contrib.pi_tar,'colorMap=',map);
    title('Inflation target');
    grid on;
    
    
subplot(236);
    b = barcon(contrib.rs_M,'colorMap=',map);
    title('Market interest rate');
    grid on;

rep.userfigure('Historical shock decomposition',f);

rep.publish(strcat('./reports/hd.pdf'), 'display',false);
