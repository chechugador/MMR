%%
%Este script obtiene los KPIs de la simulacion de la comparacion entre
%el modelo SLIP y el MMR. Los KPIs del SLIP son: 
%% 1) Longitud de la zancada del modelo
%La calcularemos como la distancia viajada durante la fase a�rea

zancadaSlip = abs(xairSlipfinal - xSlipfinal);

%% 2) Altura de la zancada (hop)
%La calcularemos como la elevaci�n max alcanzada durante la fase a�rea

maxAltura = yairSlip(1);

for i=2:length(yairSlip)
    
    if yairSlip(i) > maxAltura   
        maxAltura = yairSlip(i);    
    end
    
end

alturaSlip = maxAltura - ySlipfinal;

%% 3) Fuerza ejercida (Igual la saco de Simulink)
%Hay 3 esfuerzos: esfuerzo normal, cortante y momentos flectores
% N = M*x''
% T = M*y''
% Mz = M*y''*Lcol
% Estos se calculan en el bloque de Simulink, aqui se calcula unicamente
% la media durante la fase �erea.

% NOTA1 : En la fase a�rea del modelo SLIP, la x'' es 0, asi que
% N = 0 en el modelo SLIP (no hay compresi�n)

% NOTA2: El momento flector no es constante a lo largo de la longitud de la
% columna, es lineal. As� que se registrar�n el valor m�nimo del flector
% y el valor m�ximo.
% Mz = M*y''*xcol
% Minimo para xcol = 0      --> Mz = 0
% Maximo para xcol = Lcol   --> Mz = M*y''*Lcol

TyairMedia = mean(Tyair);
MzairMedia = mean(Mzair(1:end-1));

NxMedia = mean(Nx);
TyMedia = mean(Ty);
MzMedia = mean(Mz(1:end-1));

%Por ultimo, construimos un struct con todos los KPIs
SlipKPI.zancada = zancadaSlip;
SlipKPI.altura = alturaSlip;
SlipKPI.Fground.Nx = NxMedia;
SlipKPI.Fground.Ty = TyMedia;
SlipKPI.Fground.MzMin = 0;
SlipKPI.Fground.MzMax = MzMedia;
SlipKPI.Fair.Nx = 0;
SlipKPI.Fair.Ty = TyairMedia;
SlipKPI.Fair.MzMin = 0;
SlipKPI.Fair.MzMax = MzairMedia;

%% Se sacan los KPIs por pantalla

disp('Zancada = ' + string(zancadaSlip) + ' m   Altura = ' + string(alturaSlip) + ' m');
disp('Nx ground = ' + string(NxMedia) + ' N   Ty ground = ' + string(TyMedia) + 'N'); 
disp('Mz ground Min= ' + string(0) + ' Nm Mz ground Max = ' + string(MzMedia) + ' Nm');
disp('Nx air = ' + string(0) + ' N   Ty air = ' + string(TyairMedia) + 'N'); 
disp('Mz air Min = ' + string(0) + ' Nm Mz air Max = ' + string(MzairMedia) + ' Nm');

