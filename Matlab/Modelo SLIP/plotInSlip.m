%Ploteamos las entradas del modelo SLIP

figure;
%%
%Ploteamos alfa teorica
%subplot(211);
alfa_t.Data(end) = alfaAir.Data(1);
plot(alfa_t.Time,alfa_t.Data(:)*180/pi, 'b'); hold;
alfaAir.Time = alfaAir.Time + alfa_t.Time(end);
plot(alfaAir.Time, alfaAir.Data(:)*180/pi,'-.r'); 
plot(alfa_t.Time(length(alfa_t.Time)),alfa_t.Data(length(alfa_t.Time))*180/pi,'ko');
%title('Entrada Teórica'); xlabel('t(s)'); ylabel('Alfa(grados)');
title('Alfa'); xlabel('t(s)'); ylabel('Alfa(grados)');
axis([0 1 -100 100]);
%%
%Ploteamos alfa real
% subplot(212);
% plot(alfa_t.Time(1:length(outSlip.tout)),alfa_t.Data(:,1:length(outSlip.tout))*180/pi, 'b'); hold;
% alfaAir.Time = alfaAir.Time - alfaAir.Time(1) + alfa_t.Time(length(outSlip.tout));
% plot(alfaAir.Time((1:length(outAirSlip.tout))), alfaAir.Data(:,1:length(outAirSlip.tout))*180/pi,'-.r'); 
% plot(alfa_t.Time(length(outSlip.tout)),alfa_t.Data(length(outSlip.tout))*180/pi,'ko');
% title('Entrada Real'); xlabel('t(s)'); ylabel('Alfa(grados)');
% axis([0 1 -100 100]);

