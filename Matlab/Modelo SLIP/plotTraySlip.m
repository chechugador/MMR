%Ploteamos las trayectorias
%%
    %Ploteamos las posiciones y velocidades de m
    figure;
    subplot(2,2,1);
    plot(toutSlip, xSlip, 'b'); hold; plot(toutairSlip, xairSlip,'-.r'); plot(toutSlip(length(toutSlip)),xSlipfinal,'ko');
    title('xSlip(t)'); xlabel('t (s)'); ylabel('x (m)');
    subplot(2,2,2);
    plot(toutSlip, ySlip, 'b'); hold; plot(toutairSlip, yairSlip,'-.r'); plot(toutSlip(length(toutSlip)),ySlipfinal,'ko');
    title('ySlip(t)'); xlabel('t (s)'); ylabel('y (m)');
    subplot(2,2,3);
    plot(toutSlip, vxSlip, 'b'); hold; plot(toutairSlip, vxairSlip,'-.r'); plot(toutSlip(length(toutSlip)),vxSlipfinal,'ko');
    title('vxSlip(t)'); xlabel('t (s)'); ylabel('vx (m/s)');
    subplot(2,2,4);
    plot(toutSlip, vySlip,'b'); hold; plot(toutairSlip, vyairSlip,'-.r'); plot(toutSlip(length(toutSlip)),vySlipfinal,'ko');
    title('vySlip(t)'); xlabel('t (s)'); ylabel('vy (m/s)');

    %Ploteamos la trayectoria de m
%     figure;
%     plot(xSlip, ySlip,'xb'); 
%     hold; 
%     plot(xairSlip, yairSlip,'rx'); 
%     %hold;
%     plot(xSlipfinal,ySlipfinal,'ko');

