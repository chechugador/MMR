%Se realiza en este script el modelado cinemático y dinámico del sistema
%masa-resorte (SLIP) en péndulo invertido para el movimiento de salto
%dinámico (hopping at non-zero forward speed) 
%Valores de ctes obtenidos de disecciones del cheetah
%clear; close all;
global alfaSlip; global alfaSlipAir;
alfa = alfaSlip; 
%%
%Definición de ctes
g=-9.81;    %La gravedad va hacia abajo, pero la y positiva va hacia arriba
M=15+3;
k=2000.0;
Lhk = 0.28;
Lkf = 0.28;
L0 = Lhk + Lkf;
%alfa0 = pi/6; %Inclinacion inicial (angulo de ataque)
%alfa0 = pi/12;
%alfa0 = alfa(1);
x0 = L0 * sin(alfa0);
y0 = L0 * cos(alfa0);
%vx0 = -1;
vx0=0;
%vy0 = -1.50;
vy0 = -1.50;

Lcol = 0.70; %Invent a ojo

%%
%Se definen los tiempos
f = 3;  %Frecuencia en Hz
T = 1/f;
tc = 0.111;
T = tc/0.44;
ta = T - tc;

%tc = 0.6;
tc = 0.6;
ta = 0.6;
%ta=2.5;

%%
%Variables totales para plotear la trayectoria
xtotalSlip = 0; ytotalSlip = 0; vxtotalSlip = 0; vytotalSlip = 0; ttotalSlip = 0;

%%
%Hacemos un bucle para encadenar varios pasos
%set_param(gcs,'SimulationCommand','Update');
for cont=1:1
    
    disp('------------------ SLIP Paso ' + string(cont) +' ------------------');
    
    %%
    % Se definen las entradas del sistema: alfa y beta
    %alfa(1:51) = alfa0:-2*alfa0/50:-alfa0;
    %alfa = angulo:-angulo/100:angulo/2;
    tground=0:tc/(length(alfa)-1):tc;
    %save tground.mat -v7.3 tground;
    alfa_t = timeseries(alfa,tground);
    %%
    %Corremos el bloque simulink de la fase de contacto y extraemos datos
    set_param('slip_ground','SimulationCommand','Update');
    sim('slip_ground');
    outSlip = ans;
    %Tiempo
    toutSlip = outSlip.tout;
    %Posicion y velocidad de m
    xSlip = outSlip.xSlip; xSlip = xSlip(:,2);
    vxSlip = outSlip.vxSlip; vxSlip = vxSlip(:,2);
    ySlip = outSlip.ySlip; ySlip = ySlip(:,2);
    vySlip = outSlip.vySlip; vySlip = vySlip(:,2);
    %Esfuerzos ejercidos en la columna
    Nx = outSlip.Nx; Nx = Nx(:,2);
    Ty = outSlip.Ty; Ty = Ty(:,2);
    Mz = outSlip.Mz; Mz = Mz(:,2);
    %Posicion y velocidad finales (inicio de fase aerea)
    xSlipfinal = xSlip( length(toutSlip) );
    vxSlipfinal = vxSlip( length(toutSlip) );
    ySlipfinal = ySlip( length(toutSlip) );
    vySlipfinal = vySlip( length(toutSlip) );
    %%
    % MMR_hop_nonzero_aerial;
    %Cambiamos los valores de entrada alfa y beta
    %clear alfa; clear beta;
    alfaAir = alfaSlipAir(1:1:end);
    %alfaAir(1:51) = alfa(51);
    %tground=0:ta/(length(alfaAir)-1):ta;
    tground=0:ta/(length(alfaAir)-1):ta;
    alfaAir(length(alfaAir):length(alfaAir)) = alfaAir(length(alfaAir));
    %alfaAir(1:51) = alfa(51:1);
    %tground=0:tc/39:tc;
    %save tground.mat -v7.3 tground;
    alfaAir = timeseries(alfaAir,tground);
    %save alfaAir.mat -v7.3 alfa;
    %%
    %Simulamos fase áerea y extraemos datos
    set_param('slip_air','SimulationCommand','Update');
    sim('slip_air');
    outAirSlip = ans;
    %Reseteamos dimensiones de los vectores
    xairSlip = 0; yairSlip = 0; vxairSlip = 0; vyairSlip = 0; Tyair=0; Mzair=0;
    for i=1:length(outAirSlip.tout)
        %Posicion y velocidad de m
        xairSlip(i) = outAirSlip.xairSlip{1}.Values.Data(i);
        yairSlip(i) = outAirSlip.yairSlip{1}.Values.Data(i);
        vxairSlip(i) = outAirSlip.vxairSlip{1}.Values.Data(i);
        vyairSlip(i) = outAirSlip.vyairSlip{1}.Values.Data(i);
        Tyair(i) = outAirSlip.Ty{1}.Values.Data(i);
        Mzair(i) = outAirSlip.Mz{1}.Values.Data(i);
    end
    %Tiempo
    toutairSlip = toutSlip(length(toutSlip)) + outAirSlip.tout';
    %toutair = tc + outAir.x(:,1);
    %xair = outAir.x(:,2);
    %vxair = outAir.vx(:,2);
    %yair = outAir.y(:,2);
    %vyair = outAir.vy(:,2);
    xairSlipfinal = xairSlip( length(xairSlip) );       %x0
    vx0 = vxairSlip( length(vxairSlip) );    %vx0
    yairSlipfinal = yairSlip( length(yairSlip) );       %y0
    vy0 = vyairSlip( length(vyairSlip) );    %vy0
    %%
    %Lanzamos simulacion visual del SLIP
    visualSLIP;
    %%
    %Ploteamos las distintas trayectorias de cada iteracion
    %evalc('plotTraySlip');
    %Calculamos vectores finales
    xtotalSlip = horzcat(xtotalSlip, xSlip', xairSlip);
    ytotalSlip = horzcat(ytotalSlip, ySlip', yairSlip);
    vxtotalSlip = horzcat(vxtotalSlip, vxSlip', vxairSlip);
    vytotalSlip = horzcat(vytotalSlip, vySlip', vyairSlip);
    toutSlip = toutSlip + ttotalSlip(length(ttotalSlip));
    toutairSlip = toutairSlip + ttotalSlip(length(ttotalSlip)); 
    ttotalSlip = horzcat(ttotalSlip, toutSlip', toutairSlip);
    
    %%
    %Se calculan los diferentes KPIs
    kpiSlip;
    
end

%plotTraytotalSlip;

%%
%Ploteamos entrada
%evalc('plotInSlip');
%%
%Diagrama de fases
figure;
%subplot(2,1,1);
%plot(xtotalSlip,vxtotalSlip);title('xm-vxm'); xlabel('x (m)'); ylabel('vx (m/s)');
%subplot(2,1,2);
plot(ytotalSlip,vytotalSlip);title('ym-vym'); xlabel('y (m)'); ylabel('vy (m/s)');


