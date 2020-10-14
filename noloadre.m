%run at 4
t = 100;
U_rated=220;
R_stator=3.5;

sim('noload1.slx',t)

index = find(load.time==t);
P_0 = getdatasamples(load,index);
I_0 = getdatasamples(current,index);

P_s_0 = I_0 * I_0 * R_stator;

sim('noload2.slx',t)
index = find(torque1.time==t);
T_0 = getdatasamples(torque1,index);
P_fw = T_0 * n_rl;
P_fe = P_0 - P_s_0 - P_fw;