m = model('bgpp2008.mod', 'Linear=', true);
setparam;

m = assign(m,par);
m = sstate(solve(m));


a01preparedata;


[~,prjqpm] = filter(m,qdb,qq(2000,1):qq(2010,4),...
    'output=','pred','ahead=',12,'meanonly=',true);

plotpred(qq(2000,1):qq(2010,4),qdb.pi,
