function [alfa, alfaAir, tracks] = trayectoriaSLIP(experimento)
%%
%Esta funcion extrae los puntos de la trayectoria obtenida en Tracker
%de la hoja de datos y calcula los angulos necesarios a la entrada.
%%
%Abrimos la ruta del archivo especificado y extraemos datos del excel
cd 'D:\UNIVERSIDAD\TFM Cheetah\Videos Tracker';
switch experimento
    case 'hop'
        alfa(1:51)=0;
        alfaAir = alfa;
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
%trackm = excel(:,5:7);
trackPie = excel(:,9:11);
trackRef = excel(:,13:15);
%%
%Se calculan los angulos alfa y beta de entrada de los modelos
%alfa = arctg((xM - xpie)/(yM - ypie))
xdif = trackPie(:,2) - trackM(:,2);
ydif = trackM(:,3) - trackPie(:,3);
for i=1:size(trackM,1)
    %alfa(i) = atan(xdif(i) / ydif(i));
    alfa(i) = atan2(xdif(i), ydif(i));
end
%%
%Se crean las estructuras de datos necesarias
tracks.Data.M = trackM(:,2:3);
tracks.Data.pie = trackPie(:,2:3);
tracks.Data.ref = trackRef(:,2:3);
tracks.Time = trackM(:,1);

%Ploteamos trayectorias de entrada y salida


switch experimento
    case 'cheetah'
        %Fase Aerial
        alfaAir(1:24) = alfa(332:355); alfaAir(24:288) = alfa(1:265);
        %Fase Ground
        alfa = alfa(266:331);
        %Adecuación a tiempos
        alfa = alfa(2:2:end);
        alfaAir = alfaAir(1:6:end-24);
    case 'caballo1'
        %Fase Aerial
        alfaAir = alfa(6:14);
        %Fase Ground
        alfa = alfa(1:5);
    case 'caballo2'
        %Fase Aerial
        alfaAir = alfa(19:26);
        %Fase Ground
        alfa = alfa(15:18);
    case 'caballo3'
        %Fase Aerial
        alfaAir = alfa(31:39);
        %Fase Ground
        alfa = alfa(27:30);
    case 'canguro1'
        %Fase Aerial
        alfaAir = alfa(12:17);
        %Fase Ground
        alfa = alfa(3:11);
    case 'canguro2'
        %Fase Aerial
        alfaAir = alfa(26:31);
        %Fase Ground
        alfa = alfa(18:25);
    case 'canguro3'
        %Fase Aerial
        alfaAir = alfa(40:46);
        %Fase Ground
        alfa = alfa(32:39);
end

end

