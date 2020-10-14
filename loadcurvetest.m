%run at 3
t = 50;

%inputs
points = 6;
f=f_rated*ones(1,points);
U=V_rated*ones(1,points);
P1_lc = zeros(1,points);
P2_lc = zeros(1,points);
T_lc = zeros(1,points);
I_lc = zeros(1,points);
n_lc = zeros(1,points);
s_lc = zeros(1,points);

%outputs
P_s_lc = zeros(1,points);
kc_lc = zeros(1,points);
P_sc_lc = zeros(1,points);

%setpoints
setpoint_loads = [P_rated*1.25 P_rated*1.15 P_rated P_rated*0.75 P_rated*0.5 P_rated*0.25]; %set load points here manually

for k=1:1:points
    setpoint_load = setpoint_loads(k);
    sim('magneticbrake.slx',t)

    index = find(speed.time==t);
    P1_lc(k)=getdatasamples(load,index);
    P2_lc(k)=getdatasamples(P2,index);
    T_lc(k)=getdatasamples(torque,index);
    I_lc(k)=getdatasamples(current,index);
    n_lc(k)=getdatasamples(speed,index);
    s_lc(k)=1-(n_lc(k)/314);
    
    t_w=getdatasamples(temperature_stator,index) - 273; %'C
    kc_lc(k) = (235 + t_w + 25 - t_c)/(235 + t_w); %temperature correction factor

    P_s_lc(k) = I_lc(k)*I_lc(k)*R_stator;
    P_sc_lc(k) = P_s_lc(k) * kc_lc(k);    
end
