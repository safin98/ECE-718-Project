t_d = linspace(20,100);
t_cc = zeros(length(t_d));
t_cn = zeros(length(t_d));
t_nc = zeros(length(t_d));
t_nn = zeros(length(t_d));

for i=1:length(t_d)
    deadline = t_d(i)
    T_vals = pendulum_linprog(deadline);
    t_cc(i) = T_vals(1);
    t_nc(i) = T_vals(2);
    t_cn(i) = T_vals(3);
    t_nn(i) = T_vals(4);
end
%%
subplot(2,2,1)
plot(t_d,t_cc);
title("Reuse (Cr) vs Timer(Cr,Cr)");
xlabel("Reuse (Cr)");
ylabel("Timer(Cr,nCr)")

subplot(2,2,2)
plot(t_d,t_cn);
title("Reuse (Cr) vs Timer(Cr,nCr)");
xlabel("Reuse (Cr)");
ylabel("Timer(Cr,nCr)")

subplot(2,2,3)
plot(t_d,t_nc);
title("Reuse (Cr) vs Timer(nCr,Cr)");
xlabel("Reuse (Cr)");
ylabel("Timer(nCr,Cr)")

subplot(2,2,4)
plot(t_d,t_nn);
title("Reuse (Cr) vs Timer(nCr,nCr");
xlabel("Reuse (Cr)");
ylabel("Timer(nCr,nCr)")




