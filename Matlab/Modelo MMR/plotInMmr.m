%Ploteamos las entradas del modelo MMR

figure;
%%
%Ploteamos alfa teorica
%subplot(221);
subplot(211);
plot(alfa_t.Time,alfa_t.Data(:)*180/pi, 'b'); hold;
alfaAir_t.Time = alfaAir_t.Time + alfa_t.Time(end);
plot(alfaAir_t.Time, alfaAir_t.Data(:)*180/pi,'-.r'); 
plot(alfa_t.Time(length(alfa_t.Time)),alfa_t.Data(length(alfa_t.Time))*180/pi,'ko');
title('Alfa'); xlabel('t(s)'); ylabel('Alfa (grados)');
axis([0 1 -100 100]);
%%
%Ploteamos alfa real
%subplot(223);
% plot(alfa_t.Time(1:length(out.tout)),alfa_t.Data(:,1:length(out.tout))*180/pi, 'b'); hold;
% alfaAir_t.Time = alfaAir_t.Time - alfaAir_t.Time(1) + alfa_t.Time(length(out.tout));
% plot(alfaAir_t.Time((1:length(outAir.tout))), alfaAir_t.Data(:,1:length(outAir.tout))*180/pi,'-.r'); 
% plot(alfa_t.Time(length(out.tout)),alfa_t.Data(length(out.tout))*180/pi,'ko');
% title('Alfa Real'); xlabel('t(s)'); ylabel('Alfa (grados)');
% axis([0 1 -100 100]);
%%
% %Ploteamos beta teorica
%subplot(222);
subplot(212);
beta(end) = betaAir_t.Data(1);
plot(alfa_t.Time,beta(:)*180/pi, 'b'); hold;
betaAir_t.Time = betaAir_t.Time + alfa_t.Time(end);
plot(betaAir_t.Time, betaAir_t.Data(:)*180/pi,'-.r'); 
plot(alfa_t.Time(length(alfa_t.Time)),beta(length(alfa_t.Time))*180/pi,'ko');
title('Beta'); xlabel('t(s)'); ylabel('Beta (grados)');
axis([0 1 -100 100]);
% %%
% %Ploteamos beta real
% subplot(224);
% plot(alfa_t.Time(1:length(out.tout)),beta(:,1:length(out.tout))*180/pi, 'b'); hold;
% betaAir_t.Time = betaAir_t.Time - betaAir_t.Time(1) + alfa_t.Time(length(out.tout));
% plot(betaAir_t.Time((1:length(outAir.tout))), betaAir_t.Data(:,1:length(outAir.tout))*180/pi,'-.r'); 
% plot(alfa_t.Time(length(out.tout)),beta(length(out.tout))*180/pi,'ko');
% title('Beta Real'); xlabel('t(s)'); ylabel('Alfa (grados)');
% axis([0 1 -100 100]);

