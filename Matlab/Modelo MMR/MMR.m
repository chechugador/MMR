%Se realiza en este script el modelado cinemático y dinámico del sistema
%masa-masa-resorte en péndulo invertido para el movimiento de salto
%dinámico (hopping at non-zero forward speed). 
%Valores de ctes obtenidos de disecciones del cheetah
%clear; close all;
global alfaMMR; global betaMMR;
global alfaAirMMR; global betaAirMMR;
alfa = alfaMMR; beta = betaMMR;
%clear;
%%
%Se definen los tiempos
f = 3;  %Frecuencia en Hz
T = 1/f;
tc = 0.111;
T = tc/0.44;
ta = T - tc;
%%
%Segun Blickhan (1989) el hopping humano (similar en parámetros al de
%otros mamíferos), para f=3Hz (T=333ms) un valor típico de tc=111ms.
%tc = 0.6;
tc = 0.6;
ta = 0.6;
%ta=2.5;
%%
%Definición de ctes
g=-9.81;    %La gravedad va hacia abajo, pero la y positiva va hacia arriba
M=15;
m=3;
k=2000.0;
Lhk=0.28;   %Longitud de cadera a rodilla (fémur)
Lkf=0.28;   %Longitud de rodilla a pie (tibia)
%alfa0 = pi/6; %Inclinacion inicial (angulo de ataque)
%alfa0 = pi/12;
%beta0 = 0;  %Angulo rodilla inicial
%alfa0 = alfa(1); beta0 = beta(1);
y0 = Lkf * cos(alfa0 - beta0); %Posicion inicial del CoM de la pierna
yM0 = y0 + Lhk * cos(alfa0);
x0 = Lkf * sin(alfa0 - beta0);
xM0 = x0 + Lhk*sin(alfa0);
L0 = sqrt(x0*x0 + y0*y0);
%vx0 = -1;
vx0 = 0;
%vxM0 = vx0 - 2*alfa0/tc*Lhk*cos(alfa0);
vxM0 = vx0;
%vy0 = -1.50;
vy0 = -1.50;
%vyM0 = vy0 + 2*alfa0/tc*Lhk*sin(alfa0);
vyM0 = vy0;

Lcol = 0.70; %Invent a ojo

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
%Variables totales para plotear la trayectoria
xtotal = 0; ytotal = 0; vxtotal = 0; vytotal = 0; ttotal = 0;
xMtotal = 0; yMtotal = 0; vxMtotal = 0; vyMtotal = 0; tairtotal = 0;

%%
%Hacemos un bucle para encadenar varios pasos
%set_param(gcs,'SimulationCommand','Update');
for cont=1:1
    
    disp('------------------ MMR Paso ' + string(cont) +' ------------------');
    
    %%
    % Se definen las entradas del sistema: alfa y beta
    %alfa(1:51) = alfa0:-2*alfa0/50:-alfa0;
    %alfa = angulo:-angulo/100:angulo/2;
    tground = 0:tc/(length(alfa)-1):tc;
    alfa_t = timeseries(alfa,tground);
    %beta(1:51) = beta0:-2*beta0/50:-beta0;
    %beta(1:51)=beta0;
    beta_t = timeseries(beta,tground);
    %%
    %Corremos el bloque simulink de la fase de contacto y extraemos datos
    set_param('mmr_ground','SimulationCommand','Update');
    sim('mmr_ground');
    out = ans;
    %Reseteamos dimensiones de los vectores
    x = 0; y = 0; vx = 0; vy = 0; Ty=0; Mz=0;
    xM = 0; yM = 0; vxM = 0; vyM = 0;
    %Tiempo
%     tout = out.tout;
%     %Posicion y velocidad de m
%     x = out.x(:,2); 
%     vx = out.vx(:,2); 
%     y = out.y(:,2); 
%     vy = out.vy(:,2); 
%     %Posicion y velocidad de M
%     xM = out.xM(:,2); 
%     vxM = out.vxM(:,2); 
%     yM = out.yM(:,2); 
%     vyM = out.vyM(:,2); 
%     %Esfuerzos ejercidos en la columna
%     Nx = out.Nx(:,2); 
%     Ty = out.Ty(:,2); 
%     Mz = out.Mz(:,2); 
%     M0 = out.M0(:,2);
    
    tout = out.tout;
    for i=1:length(tout)
        %Posicion y velocidad de m
        x(i) = out.x{1}.Values.Data(i);
        y(i) = out.y{1}.Values.Data(i);
        vx(i) = out.vx{1}.Values.Data(i);
        vy(i) = out.vy{1}.Values.Data(i);
        %Posicion y velocidad de M
        xM(i) = out.xM{1}.Values.Data(i);
        yM(i) = out.yM{1}.Values.Data(i);
        vxM(i) = out.vxM{1}.Values.Data(i);
        vyM(i) = out.vyM{1}.Values.Data(i);
        %Esfuerzos de la columna
        Nx(i) = out.Nx{1}.Values.Data(i);
        Ty(i) = out.Ty{1}.Values.Data(i);
        Mz(i) = out.Mz{1}.Values.Data(i);
        MzMin(i) = out.M0{1}.Values.Data(i);
    end
    
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
    %alfaAir(1:51) = alfa(51);
    %alfaAir(1:51) = -alfa0:2*alfa0/50:alfa0;
    alfaAir = alfaAirMMR(1:1:end);  %Aligeramos un poco de info
    tground=0:ta/(length(alfaAir)-1):ta;
    alfaAir(length(alfaAir):length(alfaAir)) = alfaAir(length(alfaAir));
    %save tground.mat -v7.3 tground;
    alfaAir_t = timeseries(alfaAir,tground);
    %save alfaAir.mat -v7.3 alfa;
    %betaAir(1:51) = 0;
    betaAir = betaAirMMR(1:1:end);  %Aligeramos un poco de info
    betaAir(length(betaAir):length(betaAir)) = betaAir(length(betaAir));
    betaAir_t = timeseries(betaAir,tground);
    %save betaAir.mat -v7.3 beta;
    %%
    %Simulamos fase áerea y extraemos datos
    set_param('mmr_air_alternat','SimulationCommand','Update');
    sim('mmr_air_alternat');
    outAir = ans;
    %Reseteamos dimensiones de los vectores
    xair = 0; yair = 0; vxair = 0; vyair = 0; Tyair=0; Mzair=0;
    xMair = 0; yMair = 0; vxMair = 0; vyMair = 0;
    for i=1:length(outAir.tout)
        %Posicion y velocidad de m
        xair(i) = outAir.xair{1}.Values.Data(i);
        yair(i) = outAir.yair{1}.Values.Data(i);
        vxair(i) = outAir.vxair{1}.Values.Data(i);
        vyair(i) = outAir.vyair{1}.Values.Data(i);
        %Tiempo
        toutair = tout(length(tout)) + outAir.tout';
        %Posicion y velocidad de M
        xMair(i) = outAir.xMair{1}.Values.Data(i);
        yMair(i) = outAir.yMair{1}.Values.Data(i);
        vxMair(i) = outAir.vxMair{1}.Values.Data(i);
        vyMair(i) = outAir.vyMair{1}.Values.Data(i);
        %Esfuerzos de la columna
        Nxair(i) = outAir.Nx{1}.Values.Data(i);
        Tyair(i) = outAir.Ty{1}.Values.Data(i);
        Mzair(i) = outAir.Mz{1}.Values.Data(i);
        MzMinair(i) = outAir.M0{1}.Values.Data(i);
    end
    %toutair = tc + outAir.x(:,1);
    %xair = outAir.x(:,2);
    %vxair = outAir.vx(:,2);
    %yair = outAir.y(:,2);
    %vyair = outAir.vy(:,2);
    %Valores finales de m
    xfinalair = xair( length(xair) );       %x0
    vx0 = vxair( length(vxair) );    %vx0
    yfinalair = yair( length(yair) );       %y0
    vy0 = vyair( length(vyair) );    %vy0
    %Valores finales de M
    xMfinalair = xMair( length(xMair) );       %x0
    vxM0 = vxair( length(vxMair) );    %vx0
    yMfinalair = yair( length(yMair) );       %y0
    vyM0 = vyair( length(vyMair) );    %vy0
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
    %Ploteamos las distintas trayectorias de cada iteracion
    %evalc('plotTrayMmr');
    %Calculamos vectores finales de m
    xtotal = horzcat(xtotal, x, xair);
    ytotal = horzcat(ytotal, y, yair);
    vxtotal = horzcat(vxtotal, vx, vxair);
    vytotal = horzcat(vytotal, vy, vyair);
    %Calculamos vectores finales de M
    xMtotal = horzcat(xMtotal, xM, xMair);
    yMtotal = horzcat(yMtotal, yM, yMair);
    vxMtotal = horzcat(vxMtotal, vxM, vxMair);
    vyMtotal = horzcat(vyMtotal, vyM, vyMair);
    %Calculamos vectores finales de tiempo
    tout = tout + ttotal(length(ttotal));
    toutair = toutair + ttotal(length(ttotal)); 
    ttotal = horzcat(ttotal, tout', toutair);
    
    %%
    %Se calculan los diferentes KPIs
    kpiMMR;
    
end

%plotTraytotalMmr;
%%
%Ploteamos entrada
%evalc('plotInMmr');
%%
%Diagrama de fases
figure;
% subplot(2,2,1);
% plot(xtotal,vxtotal);title('xm-vxm'); xlabel('x (m)'); ylabel('vx (m/s)');
% subplot(2,2,2);
% plot(xMtotal,vxMtotal);title('xM-vxM'); xlabel('x (m)'); ylabel('vx (m/s)');
% subplot(2,2,3);
% plot(ytotal,vytotal);title('ym-vym'); xlabel('y (m)'); ylabel('vy (m/s)');
% subplot(2,2,4);
% plot(yMtotal,vyMtotal);title('yM-vyM'); xlabel('y (m)'); ylabel('vy (m/s)');
subplot(211);
plot(ytotal,vytotal);title('ym-vym'); xlabel('y (m)'); ylabel('vy (m/s)');
subplot(212);
plot(yMtotal,vyMtotal);title('yM-vyM'); xlabel('y (m)'); ylabel('vy (m/s)');


    





