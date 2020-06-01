%% 0. Start up IRIS Toolbox:
 addpath(fullfile(getenv('USERPROFILE'),'Documents','IRISToolbox'));
 irisstartup

%% 1. Prepare the observed data.
% We need to:
% a) convert frequency to model frequency, which is quarterly;
% b) convert all growth rates to annual growth rates;
% c) convert all levels to log
% d) convert all rates to 100 log
% e) correct for seasonality, where necessary 

% true - to delete csv files, false to keep them
cleanup = false;


qdb = struct();
% o_rs
xls2csv('Input.xlsx','miacr.csv','sheet=','miacr_m');
miacrdb = dbload('miacr.csv','freq',12);
qdb.o_rs=100*log(1+convert(miacrdb.miacr,4,'method',@mean)/100);

% o_rs_f
xls2csv('Input.xlsx','effr.csv','sheet=','effr_m');
effrdb = dbload('effr.csv','freq',12);
qdb.o_rs_f=100*log(1+convert(effrdb.effr,4,'method',@mean)/100);

% o_rs_M
xls2csv('Input.xlsx','bank.csv','sheet=','bank');
bankdb = dbload('bank.csv','freq',12);
qdb.o_rs_M = 100*log(1+convert(bankdb.bank,4,'method',@mean)/100);

% o_rho
xls2csv('Input.xlsx','cds.csv','sheet=','cds_m');
cdsdb = dbload('cds.csv','freq',12);
qdb.o_rho = 100*log(1+convert(cdsdb.cds/100,4,'method',@mean));

% o_pi
xls2csv('Input.xlsx','cpi.csv','sheet=','cpi');
cpidb = dbload('cpi.csv','freq',12);
cpidb.cpisa = x12(cpidb.lvlcpi);
qdb.o_pi = 100*4*(diff(log(convert(cpidb.cpisa,4,'method',@mean))));

% o_pi_f
xls2csv('Input.xlsx','cpi_f.csv','sheet=','cpi_f');
cpifdb = dbload('cpi_f.csv','freq',12);
qdb.o_pi_f = 100*4*(diff(log(convert(cpifdb.cpi_us,4,'method','last'))));

% o_y
xls2csv('Input.xlsx','y.csv','sheet=','y');
ydb = dbload('y.csv','freq',4,'dateformat','m/d/yyyy');
qdb.o_y = 100*(log(ydb.gdp));

% o_y_f_gap
xls2csv('Input.xlsx','y_f.csv','sheet=','y_f');
yfdb = dbload('y_f.csv','freq',4,'dateformat','m/d/yyyy');
qdb.o_y_f_gap = 100*(hpf2(yfdb.y_f,qq(2000,1):qq(2018,4))/yfdb.y_f);

% o_ls
xls2csv('Input.xlsx','usd.csv','sheet=','usd_m');
usddb = dbload('usd.csv','freq',12);
qdb.o_ls = 100*(log(convert(usddb.usdrub,4,'method',@mean)));

if cleanup, delete *.csv, end