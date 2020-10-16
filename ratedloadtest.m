%run at 2
setpoint_load = P_rated;
t = 500;
sim('magneticbrake.slx',t)

index = find(speed.time==t);
P1_rl=getdatasamples(load,index);
P2_rl=getdatasamples(P2,index);
T_rl=getdatasamples(torque,index);
I_rl=getdatasamples(current,index);
n_rl=getdatasamples(speed,index);
U_rl=V_rated;
f_rl=f_rated;
R = R_stator;
t_c=air_temp - 273; %'C
t_w=getdatasamples(temperature_stator,index) - 273; %'C

kc = (235 + t_w + 25 - t_c)/(235 + t_w); %temperature correction factor

slip_rl = 1-(n_rl/314);
P_s_rl =  I_rl * I_rl * R;
P_sc_rl = P_s_rl * kc;
