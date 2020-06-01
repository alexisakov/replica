m = model('bgpp2008.mod', 'Linear=', true);
setparam;

m = assign(m,par);
m = sstate(solve(m));

[X,Y,List,A,B] = fevd(m,12);

fevdVarList = {'pi', 'ls', 'y', 'rs', 'rho', 'rs_M'};

rep = report.new('FEVD Report', 'visible', false,'colsep',0.1);

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
    dat = squeeze(Y('pi',:,:))';
    b = bar(dat,'BarLayout','stacked','FaceColor','flat');
    for k = 1:size(dat,2)
        b(k).CData = map(k,:);
    end
    title('Inflation (pp, QoQ SA)');
    legend('supply shock','demand shock','FX shock','monetary policy shock','target shock','Location','best');
    grid on;

subplot(232);
    dat = squeeze(Y('ls',:,:))';
    b = bar(dat,'BarLayout','stacked','FaceColor','flat');
    for k = 1:size(dat,2)
        b(k).CData = map(k,:);
    end
    title('Exchange rate');
    grid on;
    
    
subplot(233);
    dat = squeeze(Y('y',:,:))';
    b = bar(dat,'BarLayout','stacked','FaceColor','flat');
    for k = 1:size(dat,2)
        b(k).CData = map(k,:);
    end
    title('Output');
    grid on;
    
subplot(234);
    dat = squeeze(Y('rs',:,:))';
    b = bar(dat,'BarLayout','stacked','FaceColor','flat');
    for k = 1:size(dat,2)
        b(k).CData = map(k,:);
    end
    title('Policy rate');
    grid on;
    
subplot(235);
    dat = squeeze(Y('pi_tar',:,:))';
    b = bar(dat,'BarLayout','stacked','FaceColor','flat');
    for k = 1:size(dat,2)
        b(k).CData = map(k,:);
    end
    title('Inflation target');
    grid on;
    
    
subplot(236);
    dat = squeeze(Y('rs_M',:,:))';
    b = bar(dat,'BarLayout','stacked','FaceColor','flat');
    for k = 1:size(dat,2)
        b(k).CData = map(k,:);
    end
    title('Market interest rate');
    grid on;

rep.userfigure('Forecast error variance decomposition',f);

rep.publish(strcat('./reports/fevd.pdf'), 'display',false);

