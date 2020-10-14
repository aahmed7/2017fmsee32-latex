%run at 5
P_r_lc = zeros(1,6);
P_lr = zeros(1,6);

P_r_rl = (P1_rl-P_s_rl-P_fe_i)*slip_rl;

for i=1:1:length(P_r_lc)
    P_r_lc(i) = (P1_lc(i)-P_s_lc(i)-P_fe_i)*s_lc(i);
    P_lr(i) = P1_lc(i)-P2_lc(i)-P_s_lc(i)-P_r_lc(i)-P_fe_i-P_fw0;
end
%%
T2=T_lc.^2;
A = ((points*sum(P_lr.*T_lc.^2))-(sum(P_lr)*sum(T_lc.^2)))/(points*(sum(T_lc.^4))-(sum(T_lc.^2))^2);
B = sum(P_lr)/points - A*sum(T2)/points;