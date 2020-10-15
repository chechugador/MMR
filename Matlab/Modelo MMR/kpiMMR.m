%%
%Este script obtiene los KPIs de la simulacion de la comparacion entre
%el modelo SLIP y el MMR. Los KPIs del MMR son: 
%% 1) Longitud de la zancada del modelo
%La calcularemos como la distancia viajada durante la fase aérea

zancadaMmr = abs(xfinalair - xfinal);

%% 2) Altura de la zancada (hop)
%La calcularemos como la elevación max alcanzada durante la fase aérea

maxAltura = yair(1);

for i=2:length(yair)
    
    if yair(i) > maxAltura   
        maxAltura = yair(i);    
    end
    
end

alturaMmr = maxAltura - yfinal;

%% 3) Fuerza ejercida (Igual la saco de Simulink)
%Hay 3 esfuerzos: esfuerzo normal, cortante y momentos flectores
% N = M*xM'' + m*xm''
% T = M*yM'' + m*ym''
% Mz0 = Lhk*m*sqrt(xm''^2 + ym''^2)
% Mzfinal = Mz0 + Lcol*M*yM''
% Estos se calculan en el bloque de Simulink, aqui se calcula unicamente
% la media durante la fase áerea.

% NOTA1 : En la fase aérea del modelo MMR, la x'' y la y'' dependen
% del valor de los ángulos en cada momento, así que, a priori, no es 0

% NOTA2: El momento flector no es constante a lo largo de la longitud de la
% columna, es lineal. Así que se registrarán el valor mínimo del flector
% y el valor máximo.
% Mz = M*y''*xcol
% Minimo para xcol = 0      --> Mz = 0
% Maximo para xcol = Lcol   --> Mz = M*y''*Lcol

NxairMedia = mean(Nxair);
TyairMedia = mean(Tyair);
MzairMedia = mean(Mzair(1:end-1));
M0airMedia = mean(MzMinair(1:end-1));

NxMedia = mean(Nx);
TyMedia = mean(Ty);
MzMedia = mean(Mz(1:end-1));
M0Media = mean(MzMin(1:end-1));

%Por ultimo, construimos un struct con todos los KPIs
MmrKPI.zancada = zancadaMmr;
MmrKPI.altura = alturaMmr;
MmrKPI.Fground.Nx = NxMedia;
MmrKPI.Fground.Ty = TyMedia;
MmrKPI.Fground.MzMin = M0Media;
MmrKPI.Fground.MzMax = MzMedia;
MmrKPI.Fair.Nx = NxairMedia;
MmrKPI.Fair.Ty = TyairMedia;
MmrKPI.Fair.MzMin = M0airMedia;
MmrKPI.Fair.MzMax = MzairMedia;

%% Se sacan los KPIs por pantalla

disp('Zancada = ' + string(zancadaMmr) + ' m   Altura = ' + string(alturaMmr) + ' m');
disp('Nx ground = ' + string(NxMedia) + ' N   Ty ground = ' + string(TyMedia) + 'N'); 
disp('Mz ground Min = ' + string(M0Media) + ' Nm Mz ground Max = ' + string(MzMedia) + ' Nm');
disp('Nx air = ' + string(NxairMedia) + ' N   Ty air = ' + string(TyairMedia) + 'N'); 
disp('Mz air Min = ' + string(M0airMedia) + ' Nm Mz air Max = ' + string(MzairMedia) + ' Nm');

