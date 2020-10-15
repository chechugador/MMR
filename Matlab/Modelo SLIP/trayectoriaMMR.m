function [alfa, beta, alfaAir, betaAir, tracks] = trayectoriaMMR(experimento)
%%
%Esta funcion extrae los puntos de la trayectoria obtenida en Tracker
%de la hoja de datos y calcula los angulos necesarios a la entrada.
%%
%Abrimos la ruta del archivo especificado y extraemos datos del excel
%NOTA: Para el caso del caballo y del canguro existen diversos pasos
cd 'D:\UNIVERSIDAD\TFM Cheetah\Videos Tracker';
switch experimento
    case 'hop'
        alfa(1:51)=0;
        beta(1:51) = 0;
        alfaAir = alfa;
        betaAir = beta;
        tracks = 0;
        return;
    case 'cheetah'
        excel = xlsread('Cheetah\Trayectorias.xlsx');
    case 'caballo1'
        excel = xlsread('Caballo\Trayectorias.xlsx');
    case 'caballo2'
        excel = xlsread('Caballo\Trayectorias.xlsx');
    case 'caballo3'
        excel = xlsread('Caballo\Trayectorias.xlsx');
    case 'canguro1'
        excel = xlsread('Canguro\Trayectorias.xlsx');
    case 'canguro2'
        excel = xlsread('Canguro\Trayectorias.xlsx');
    case 'canguro3'
        excel = xlsread('Canguro\Trayectorias.xlsx');
end
%%
%Se dividen los datos extraidos
trackM = excel(:,1:3);
trackm = excel(:,5:7);
trackPie = excel(:,9:11);
trackRef = excel(:,13:15);
%%
%Se calculan los angulos alfa y beta de entrada de los modelos
%alfa = arctg((xM - xm)/(yM - ym))
%beta = arctg((xm - xpie)/(ym - ypie))
xdif = trackm(:,2) - trackM(:,2);
ydif = trackM(:,3) - trackm(:,3);
for i=1:size(trackM,1)
    %alfa(i) = atan(xdif(i) / ydif(i));
    alfa(i) = atan2(xdif(i), ydif(i));
end
xdif = trackPie(:,2) - trackm(:,2);
ydif = trackm(:,3) - trackPie(:,3);
for i=1:size(trackm,1)
    %beta(i) = atan(xdif(i) / ydif(i));
    beta(i) = alfa(i) - atan2(xdif(i), ydif(i));
end
%%
%Se crean las estructuras de datos necesarias
tracks.Data.M = trackM(:,2:3);
tracks.Data.m = trackm(:,2:3);
tracks.Data.pie = trackPie(:,2:3);
tracks.Data.ref = trackRef(:,2:3);
tracks.Time = trackM(:,1);

switch experimento
    case 'cheetah'
        %Fase Aerial
        alfaAir(1:24) = alfa(332:355); alfaAir(24:288) = alfa(1:265);
        betaAir(1:24) = beta(332:355); betaAir(24:288) = beta(1:265);
        %Fase Ground
        alfa = alfa(266:331);
        beta = beta(266:331);
        %Adecuacion a tiempos
        alfa = alfa(2:2:end);
        beta = beta(2:2:end);
        alfaAir = alfaAir(1:6:end-24);
        betaAir = betaAir(1:6:end-24);
    case 'caballo1'
        %Fase Aerial
        alfaAir = alfa(6:14);
        betaAir = beta(6:14);
        %Fase Ground
        alfa = alfa(1:5);
        beta = beta(1:5);
    case 'caballo2'
        %Fase Aerial
        alfaAir = alfa(19:26);
        betaAir = beta(19:26);
        %Fase Ground
        alfa = alfa(15:18);
        beta = beta(15:18);
    case 'caballo3'
        %Fase Aerial
        alfaAir = alfa(31:39);
        betaAir = beta(31:39);
        %Fase Ground
        alfa = alfa(27:30);
        beta = beta(27:30);
    case 'canguro1'
        %Fase Aerial
        alfaAir = alfa(12:17);
        betaAir = beta(12:17);
        %Fase Ground
        alfa = alfa(3:11);
        beta = beta(3:11);
    case 'canguro2'
        %Fase Aerial
        alfaAir = alfa(26:31);
        betaAir = beta(26:31);
        %Fase Ground
        alfa = alfa(18:25);
        beta = beta(18:25);
    case 'canguro3'
        %Fase Aerial
        alfaAir = alfa(40:46);
        betaAir = beta(40:46);
        %Fase Ground
        alfa = alfa(32:39);
        beta = beta(32:39);
end

end

