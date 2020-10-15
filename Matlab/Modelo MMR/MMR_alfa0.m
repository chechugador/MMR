%Se realiza en este script el modelado cinemático y dinámico del sistema
%masa-masa-resorte en péndulo invertido para el movimiento de salto
%dinámico (hopping at non-zero forward speed) pero con los valores para
%el salto estático. (modelo dinámico realizando trayectoria estática)
%Valores de ctes obtenidos de disecciones del cheetah
%%
%Definición de ctes
g=-9.81;    %La gravedad va hacia abajo, pero la y positiva va hacia arriba
M=15;
m=3;
k=22500;
Lhk=0.28;   %Longitud de cadera a rodilla (fémur)
Lkf=0.28;   %Longitud de rodilla a pie (tibia)
y0 = Lkf; %Posicion inicial del CoM de la pierna
yM0 = y0 + Lhk;
%y0 = 0;
x0 = 0;
xM0 = x0 + 0;
L0 = sqrt(x0*x0 + y0*y0);
vx0 = 0;
vxM0 = 0;
vy0 = -0.70;
vyM0 = vy0;

w = sqrt(k / (M + m));  %Frecuencia mecánica
%%
%El sistema presenta dos ecuaciones. Una en x y otra en y:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M*xm'' + M*Lhk*(alfa''*cos(alfa) - alfa'*alfa'*sin(alfa)) + m*xm'' 
%                               =
%                   k*L0*sin(beta) - k * xm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M*ym'' + M*Lhk*(alfa''*sin(alfa) - alfa'*alfa'*cos(alfa)) + m*ym'' 
%                               =
%              k*L0*cos(beta) - k * ym - (M + m)*g
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
%save alfa.mat -v7.3 alfa;
beta(1:51) = 0;
%beta_t = timeseries(beta,tground);
%save beta.mat -v7.3 beta;
%%
%Corremos el bloque simulink de la fase de contacto y extraemos datos
set_param(gcs,'SimulationCommand','Update');
%set_param(bdroot,'SimulationCommand','Update')
sim('mmr_ground');
out = ans;
%Tiempo
tout = out.tout;
%Posicion y velocidad de m
x = out.x; x = x(:,2);
vx = out.vx; vx = vx(:,2);
y = out.y; y = y(:,2);
vy = out.vy; vy = vy(:,2);
%Posicion y velocidad de M
xM = out.xM; xM = xM(:,2);
vxM = out.vxM; vxM = vxM(:,2);
yM = out.yM; yM = yM(:,2);
vyM = out.vyM; vyM = vyM(:,2);
%Posicion y velocidad finales (inicio de fase aerea)
xfinal = x( length(x) );
vxfinal = vx( length(vx) );
yfinal = y( length(y) );
vyfinal = vy( length(vy) );
xMfinal = xM( length(xM) );
vxMfinal = vxM( length(vxM) );
yMfinal = yM( length(yM) );
vyMfinal = vyM( length(vyM) );
%%
% MMR_hop_nonzero_aerial;
%Cambiamos los valores de entrada alfa y beta
%clear alfa; clear beta;
alfaAir(1:51) = alfa(51);
tground=0:tc/39:tc;
%save tground.mat -v7.3 tground;
%alfa = timeseries(alfa,tground);
%save alfaAir.mat -v7.3 alfa;
betaAir(1:51) = 0;
%beta = timeseries(beta,tground);
%save betaAir.mat -v7.3 beta;
%%
%Simulamos fase áerea y extraemos datos
sim('mmr_air');
outAir = ans;
for i=1:size(outAir.xair{1}.Values.Data,1)
    %Posicion y velocidad de m
    xair(i) = outAir.xair{1}.Values.Data(i);
    yair(i) = outAir.yair{1}.Values.Data(i);
    vxair(i) = outAir.vxair{1}.Values.Data(i);
    vyair(i) = outAir.vyair{1}.Values.Data(i);
    %Tiempo
    toutair = tc + outAir.tout';
    %Posicion y velocidad de M
    xMair(i) = outAir.xMair{1}.Values.Data(i);
    yMair(i) = outAir.yMair{1}.Values.Data(i);
    vxMair(i) = outAir.vxMair{1}.Values.Data(i);
    vyMair(i) = outAir.vyMair{1}.Values.Data(i);
end
%toutair = tc + outAir.x(:,1);
%xair = outAir.x(:,2);
%vxair = outAir.vx(:,2);
%yair = outAir.y(:,2);
%vyair = outAir.vy(:,2);
xfinalair = xair( length(xair) );       %x0
vxfinalair = vxair( length(vxair) );    %vx0
yfinalair = yair( length(yair) );       %y0
vyfinalair = vyair( length(vyair) );    %vy0
%%
%Concatenamos en los vectores totales
% xtotal = cat(2,x,xair);
% ytotal = cat(2,y,yair);
% vxtotal = cat(2,vx,vxair);
% vytotal = cat(2,vy,vyair);
% ttotal = cat(2,tout,toutair); 
%%
%Lanzamos simulacion visual
visualMMR;
%%
%Ploteamos las posiciones y velocidades de m
figure;
subplot(2,2,1);
plot(tout, x, 'b'); hold; plot(toutair, xair,'-.r'); plot(tc,xfinal,'ko');
title('xm(t)'); xlabel('t (s)'); ylabel('x (m)');
subplot(2,2,2);
plot(tout, y, 'b'); hold; plot(toutair, yair,'-.r'); plot(tc,yfinal,'ko');
title('ym(t)'); xlabel('t (s)'); ylabel('y (m)');
subplot(2,2,3);
plot(tout, vx, 'b'); hold; plot(toutair, vxair,'-.r'); plot(tc,vxfinal,'ko');
title('vxm(t)'); xlabel('t (s)'); ylabel('vx (m/s)');
subplot(2,2,4);
plot(tout, vy,'b'); hold; plot(toutair, vyair,'-.r'); plot(tc,vyfinal,'ko');
title('vym(t)'); xlabel('t (s)'); ylabel('vy (m/s)');

%Ploteamos la trayectoria de m
figure;
plot(x, y,'xb'); 
hold; 
plot(xair, yair,'rx'); 
%hold;
plot(xfinal,yfinal,'ko');
%%
%Ploteamos las posiciones y velocidades de M
figure;
subplot(2,2,1);
plot(tout, xM, 'b'); hold; plot(toutair, xMair,'-.r'); plot(tc,xMfinal,'ko');
title('xM(t)'); xlabel('t (s)'); ylabel('xM (m)');
subplot(2,2,2);
plot(tout, yM, 'b'); hold; plot(toutair, yMair,'-.r'); plot(tc,yMfinal,'ko');
title('yM(t)'); xlabel('t (s)'); ylabel('yM (m)');
subplot(2,2,3);
plot(tout, vxM, 'b'); hold; plot(toutair, vxMair,'-.r'); plot(tc,vxMfinal,'ko');
title('vxM(t)'); xlabel('t (s)'); ylabel('vxM (m/s)');
subplot(2,2,4);
plot(tout, vyM,'b'); hold; plot(toutair, vyMair,'-.r'); plot(tc,vyMfinal,'ko');
title('vyM(t)'); xlabel('t (s)'); ylabel('vyM (m/s)');

%Ploteamos la trayectoria de m
figure;
plot(xM, yM,'xb'); 
hold; 
plot(xMair, yMair,'rx'); 
%hold;
plot(xMfinal,yMfinal,'ko');

%%
%Segun Blickhan (1989) el hopping humano (similar en parámetros al de
%otros mamíferos), para f=3Hz (T=333ms) un valor típico de tc=111ms.




