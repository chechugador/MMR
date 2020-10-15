%Se realiza en este script el modelado cinemático y dinámico del sistema
%masa-resorte (SLIP) en péndulo invertido para el movimiento de salto
%dinámico (hopping at non-zero forward speed) pero con los valores para
%el salto estático. (modelo dinámico realizando trayectoria estática)
%Valores de ctes obtenidos de disecciones del cheetah
%%
%Definición de ctes
g=-9.81;    %La gravedad va hacia abajo, pero la y positiva va hacia arriba
M=15+3;
k=22500;
L0 = 0.28+0.28;
x0 = 0;
y0 = L0;
vx0 = 0;
vy0 = -0.70;

%%
%Se definen los tiempos
f = 3;  %Frecuencia en Hz
T = 1/f;
tc = 0.111;
T = tc/0.44;
ta = T - tc;
%%
% Se definen las entradas del sistema: alfa y beta
alfa(1:51)=0;
%alfa = angulo:-angulo/100:angulo/2;
tground=0:tc/50:tc;
%save tground.mat -v7.3 tground;
alfa_t = timeseries(alfa,tground);
%%
%Corremos el bloque simulink de la fase de contacto y extraemos datos
set_param(gcs,'SimulationCommand','Update');
%set_param(bdroot,'SimulationCommand','Update')
sim('slip_ground');
outSlip = ans;
%Tiempo
toutSlip = outSlip.tout;
%Posicion y velocidad de m
xSlip = outSlip.xSlip; xSlip = xSlip(:,2);
vxSlip = outSlip.vxSlip; vxSlip = vxSlip(:,2);
ySlip = outSlip.ySlip; ySlip = ySlip(:,2);
vySlip = outSlip.vySlip; vySlip = vySlip(:,2);
%Posicion y velocidad finales (inicio de fase aerea)
xSlipfinal = xSlip( length(xSlip) );
vxSlipfinal = vxSlip( length(vxSlip) );
ySlipfinal = ySlip( length(ySlip) );
vySlipfinal = vySlip( length(vySlip) );
%%
% MMR_hop_nonzero_aerial;
%Cambiamos los valores de entrada alfa y beta
%clear alfa; clear beta;
alfaAir(1:51) = alfa(51);
tground=0:tc/39:tc;
%save tground.mat -v7.3 tground;
%alfa = timeseries(alfa,tground);
%save alfaAir.mat -v7.3 alfa;
%%
%Simulamos fase áerea y extraemos datos
sim('slip_air');
outAirSlip = ans;
for i=1:size(outAirSlip.xairSlip{1}.Values.Data,1)
    %Posicion y velocidad de m
    xairSlip(i) = outAirSlip.xairSlip{1}.Values.Data(i);
    yairSlip(i) = outAirSlip.yairSlip{1}.Values.Data(i);
    vxairSlip(i) = outAirSlip.vxairSlip{1}.Values.Data(i);
    vyairSlip(i) = outAirSlip.vyairSlip{1}.Values.Data(i);
    %Tiempo
    toutairSlip = tc + outAirSlip.tout';
end
%toutair = tc + outAir.x(:,1);
%xair = outAir.x(:,2);
%vxair = outAir.vx(:,2);
%yair = outAir.y(:,2);
%vyair = outAir.vy(:,2);
xfinalairSlip = xairSlip( length(xairSlip) );       %x0
vxfinalairSlip = vxairSlip( length(vxairSlip) );    %vx0
yfinalairSlip = yairSlip( length(yairSlip) );       %y0
vyfinalairSlip = vyairSlip( length(vyairSlip) );    %vy0
%%
%Lanzamos simulacion visual del SLIP
visualSLIP;
%%
%Ploteamos las posiciones y velocidades de m
figure;
subplot(2,2,1);
plot(toutSlip, xSlip, 'b'); hold; plot(toutairSlip, xairSlip,'-.r'); plot(tc,xSlipfinal,'ko');
title('xSlip(t)'); xlabel('t (s)'); ylabel('x (m)');
subplot(2,2,2);
plot(toutSlip, ySlip, 'b'); hold; plot(toutairSlip, yairSlip,'-.r'); plot(tc,ySlipfinal,'ko');
title('ySlip(t)'); xlabel('t (s)'); ylabel('y (m)');
subplot(2,2,3);
plot(toutSlip, vxSlip, 'b'); hold; plot(toutairSlip, vxairSlip,'-.r'); plot(tc,vxSlipfinal,'ko');
title('vxSlip(t)'); xlabel('t (s)'); ylabel('vx (m/s)');
subplot(2,2,4);
plot(toutSlip, vySlip,'b'); hold; plot(toutairSlip, vyairSlip,'-.r'); plot(tc,vySlipfinal,'ko');
title('vySlip(t)'); xlabel('t (s)'); ylabel('vy (m/s)');

%Ploteamos la trayectoria de m
figure;
plot(xSlip, ySlip,'xb'); 
hold; 
plot(xairSlip, yairSlip,'rx'); 
%hold;
plot(xSlipfinal,ySlipfinal,'ko');

