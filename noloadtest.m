%run at 4
t = 100;
U_rated=220;
R_stator=3.9;

%inputs
points = 8;
P_0 = zeros(1,points);
I_0 = zeros(1,points);
n_0 = zeros(1,points);
T_0 = zeros(1,points);
s_0 = zeros(1,points);

%outputs
P_s_nl = zeros(1,points);
P_c_nl = zeros(1,points);

%setpoints
voltage_levels = [U_rated*1.1 U_rated U_rated*0.95 U_rated*0.9 U_rated*0.55 U_rated*0.5 U_rated*0.45 U_rated*0.4];
%%
for k=1:1:points
    U=voltage_levels(k);
    
    sim('noload.slx',t)
    
    
    index = find(load_nl.time==t);
    P_0(k)=getdatasamples(load_nl,index);
    I_0(k)=getdatasamples(current_nl,index);
    n_0(k)=getdatasamples(speed,index);
    s_0(k)=1-(n_0(k)/314);
    
    P_s_nl(k) = I_0(k) * I_0(k) * R_stator;
    P_c_nl(k) = (P_0(k) - P_s_nl(k));
end
%%
P_c_fw=P_c_nl(5:8);
U_fw = voltage_levels(5:8);
U_fe = voltage_levels(1:4);
U_fw2=U_fw.^2;
P_fw0=interp1(U_fw2,P_c_fw,0,'linear','extrap');
%P_fw0=17.84;
P_c_fe=P_c_nl(1:4);
P_fe=P_c_fe-P_fw0;

 cp=P1_rl/(sqrt(3)*U_rated*I_rl);
 sp=sqrt(1-cp^2);
 
 U_i = sqrt((U_rated-sqrt(3)/2*I_rl*R*cp)^2+(sqrt(3)/2*I_rl*R*sp)^2);
 P_fe_i=interp1(U_fe,P_fe,U_i,'linear','extrap');

U=200;