%Ploteamos las trayectorias
%%
    %Ploteamos las posiciones y velocidades de m
    figure;
    subplot(2,2,1);
    plot(ttotal, xtotal, 'b'); %hold; plot(tairtotalSlip, xairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),xSlipfinal,'ko');
    title('xm(t)'); xlabel('t (s)'); ylabel('x (m)');
    subplot(2,2,2);
    plot(ttotal, ytotal, 'b'); %hold; plot(tairtotalSlip, yairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),ySlipfinal,'ko');
    title('ym(t)'); xlabel('t (s)'); ylabel('y (m)');
    subplot(2,2,3);
    plot(ttotal, vxtotal, 'b');% hold; plot(tairtotalSlip, vxairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),vxSlipfinal,'ko');
    title('vxm(t)'); xlabel('t (s)'); ylabel('vx (m/s)');
    subplot(2,2,4);
    plot(ttotal, vytotal,'b'); %hold; plot(tairtotalSlip, vyairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),vySlipfinal,'ko');
    title('vym(t)'); xlabel('t (s)'); ylabel('vy (m/s)');
    
    %Ploteamos las posiciones y velocidades de M
    figure;
    subplot(2,2,1);
    plot(ttotal, xMtotal, 'b'); %hold; plot(tairtotalSlip, xairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),xSlipfinal,'ko');
    title('xM(t)'); xlabel('t (s)'); ylabel('x (m)');
    subplot(2,2,2);
    plot(ttotal, yMtotal, 'b'); %hold; plot(tairtotalSlip, yairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),ySlipfinal,'ko');
    title('yM(t)'); xlabel('t (s)'); ylabel('y (m)');
    subplot(2,2,3);
    plot(ttotal, vxMtotal, 'b');% hold; plot(tairtotalSlip, vxairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),vxSlipfinal,'ko');
    title('vxM(t)'); xlabel('t (s)'); ylabel('vx (m/s)');
    subplot(2,2,4);
    plot(ttotal, vyMtotal,'b'); %hold; plot(tairtotalSlip, vyairtotalSlip,'-.r'); %plot(toutSlip(length(toutSlip)),vySlipfinal,'ko');
    title('vyM(t)'); xlabel('t (s)'); ylabel('vy (m/s)');

    %Ploteamos la trayectoria de m
%     figure;
%     plot(xtotal, ytotal,'xb'); 

    %Ploteamos la trayectoria de M
%     figure;
%     plot(xMtotal, yMtotal,'xb'); 

