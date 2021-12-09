function T_vals = pendulum_linprog(t_r_cr)

n_Cr = 2;
n_nCr = 2;
SW = 10;
TDM = n_Cr*SW;
%t_r_cr = 70;
t_r_ncr = 80;
t_d = 100;    % Vector of length n_Cr
N_tot = n_Cr+n_nCr;

%%
% *** FORMULATION ***
T = optimvar('T',2,2,'LowerBound',TDM);         % T(1,1) -> T(Cr,Cr), T(1,2) -> T(Cr,nCr), T(2,1) -> T(nCr,Cr), T(2,2) -> (nCr,nCr)
t_avg = optimexpr(n_Cr);

for j = 1:n_Cr
    t_avg(j) = T(1,1) + n_nCr*T(2,1) - T(1,2)*n_nCr;
end

for j = n_Cr+1:N_tot
     t_avg(j) = T(2,2) + n_Cr*T(1,2) - n_Cr*T(2,1);
end

% for j = 1:n_nCr;
%      t_avg(j) = T(2,2) + n_Cr*T(1,2) - n_Cr*T(2,1);
% end

%obj = prod(t_avg);           % Objective function
%obj = obj ^ (1/N_tot);       % Geometric mean
%obj = mean(t_avg);
prob = optimproblem('Objective', mean(t_avg), 'ObjectiveSense','minimize');

%%
% *** CONSTRAINTS ***
WCL = n_Cr*T(1,1) + T(2,1) + n_Cr*(n_Cr-2)*SW;
wcl_con = WCL <= t_d;
reuse_con1 = T(1,1) <= max(t_r_cr);
reuse_con2 = T(2,2) <= max(t_r_ncr);
reuse_con3 = T(1,2) <= max(t_r_cr);
reuse_con4 = T(2,1) <= max(t_r_ncr);
%lower_bound_con = T(:) >= TDM;   % TDM period

prob.Constraints.cons1 = wcl_con;
prob.Constraints.cons2 = reuse_con1;
prob.Constraints.cons3 = reuse_con2;
prob.Constraints.cons4 = reuse_con3;
prob.Constraints.cons5 = reuse_con4;
%prob.Constraints.cons6 = lower_bound_con;

%T0.T = ones(2,2);
show(prob);

%%
% *** SOLVE ***
problem = prob2struct(prob);
%[T_vals, fval] = solve(prob, T0);
[T_vals,fval,exitflag,output] = linprog(problem);


