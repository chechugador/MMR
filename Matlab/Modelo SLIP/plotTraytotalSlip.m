%Ploteamos las trayectorias
%%
    %Ploteamos las posiciones y velocidades de m
    figure;
    subplot(2,2,1);
    plot(ttotalSlip, xtotalSlip, 'b'); %hold; plot(tairtotalSlip, xairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),xSlipfinal,'ko');
    title('xSlip(t)'); xlabel('t (s)'); ylabel('x (m)');
    subplot(2,2,2);
    plot(ttotalSlip, ytotalSlip, 'b'); %hold; plot(tairtotalSlip, yairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),ySlipfinal,'ko');
    title('ySlip(t)'); xlabel('t (s)'); ylabel('y (m)');
    subplot(2,2,3);
    plot(ttotalSlip, vxtotalSlip, 'b');% hold; plot(tairtotalSlip, vxairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),vxSlipfinal,'ko');
    title('vxSlip(t)'); xlabel('t (s)'); ylabel('vx (m/s)');
    subplot(2,2,4);
    plot(ttotalSlip, vytotalSlip,'b'); %hold; plot(tairtotalSlip, vyairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),vySlipfinal,'ko');
    title('vySlip(t)'); xlabel('t (s)'); ylabel('vy (m/s)');

    %Ploteamos la trayectoria de m
%     figure;
%     plot(xtotalSlip, ytotalSlip,'xb'); 

