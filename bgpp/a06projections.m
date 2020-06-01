m = model('bgpp2008.mod', 'Linear=', true);
setparam;

m = assign(m,par);
m = sstate(solve(m));

a01preparedata;

qdb.o_ls_qq = 4*diff(qdb.o_ls); % (21)

[~,prjqpm] = filter(m,qdb,qq(2006,1):qq(2010,4),...
    'output=','pred','ahead=',12,'meanonly=',true);

rmseqpmpi = [rmse(qdb.o_pi,prjqpm.pi)]

rmseqpmls = [rmse(qdb.o_ls_qq,prjqpm.ls_qq)]

rmseqpmrs = [rmse(qdb.o_rs,prjqpm.rs)]
%% VAR RMSE

eHist = qq(2010,4);
sFcst = qq(2006,1);
sHist = qq(2004,1);
maxpseudo = 12;

varOrder =1 ;

vardb=qdb*{'o_rs','o_rs_f','o_rho','o_pi','o_pi_f','o_ls_qq'};
vardb = dbclip(vardb,qq(2004,1):qq(2012,4))


error = zeros(6, 12);

 

for i=1:(eHist-1-sFcst)

    curntDate = sFcst + i - 1;

    dbclipped = dbclip(vardb,sHist:curntDate);

    varOrder = 1;
    var = VAR({'o_rs','o_rs_f','o_rho','o_pi','o_pi_f','o_ls_qq'});
    
    [var, varD] = estimate(var, vardb,qq(2004,1):curntDate,'order=', varOrder)

    simdb = simulate(var, dbclipped, curntDate+1:curntDate+12);

    proj = db2array(simdb,{'o_rs','o_rs_f','o_rho','o_pi','o_pi_f','o_ls_qq'},curntDate+1:curntDate+24)';

    k = min(maxpseudo, (eHist - sFcst) - i)

    error(:,1:k) = error(:,1:k) + ((db2array(dbclip(vardb, curntDate+1:curntDate+k))' - proj(:,1:k)).^2);
end

 
div = (eHist - sFcst) : -1 : (eHist - sFcst - maxpseudo +1)

div = repmat(div,6,1);

error = error./div;

rmsevar = error.^(0.5);

export(rmsevar,'rmse.csv')
