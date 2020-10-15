%Ploteamos las trayectorias
    %%
    %Ploteamos las posiciones y velocidades de m
    figure;
    subplot(2,2,1);
    plot(tout, x, 'b'); hold; plot(toutair, xair,'-.r'); plot(tout(length(tout)),xfinal,'ko');
    title('xm(t)'); xlabel('t (s)'); ylabel('x (m)');
    subplot(2,2,2);
    %yair(2:end+1) = yair; 
    yair(1) = yfinal;
    %tspecial = toutair; tspecial(2:end+1) = tspecial; tspecial(1) = tout(length(tout));
    plot(tout, y, 'b'); hold; plot(toutair, yair,'-.r'); plot(tout(length(tout)),yfinal,'ko');
    %plot(tout, y, 'b'); hold; plot(tspecial, yair,'-.r'); plot(tout(length(tout)),yfinal,'ko');
    title('ym(t)'); xlabel('t (s)'); ylabel('y (m)');
    subplot(2,2,3);
    plot(tout, vx, 'b'); hold; plot(toutair, vxair,'-.r'); plot(tout(length(tout)),vxfinal,'ko');
    title('vxm(t)'); xlabel('t (s)'); ylabel('vx (m/s)');
    subplot(2,2,4);
    plot(tout, vy,'b'); hold; plot(toutair, vyair,'-.r'); plot(tout(length(tout)),vyfinal,'ko');
    title('vym(t)'); xlabel('t (s)'); ylabel('vy (m/s)');

    %Ploteamos la trayectoria de m
%     figure;
%     plot(x, y,'xb'); 
%     hold; 
%     plot(xair, yair,'rx'); 
%     %hold;
%     plot(xfinal,yfinal,'ko');
    %%
    %Ploteamos las posiciones y velocidades de M
    figure;
    subplot(2,2,1);
    plot(tout, xM, 'b'); hold; plot(toutair, xMair,'-.r'); plot(tout(length(tout)),xMfinal,'ko');
    title('xM(t)'); xlabel('t (s)'); ylabel('xM (m)');
    subplot(2,2,2);
    plot(tout, yM, 'b'); hold; plot(toutair, yMair,'-.r'); plot(tout(length(tout)),yMfinal,'ko');
    title('yM(t)'); xlabel('t (s)'); ylabel('yM (m)');
    subplot(2,2,3);
    plot(tout, vxM, 'b'); hold; plot(toutair, vxMair,'-.r'); plot(tout(length(tout)),vxMfinal,'ko');
    title('vxM(t)'); xlabel('t (s)'); ylabel('vxM (m/s)');
    subplot(2,2,4);
    plot(tout, vyM,'b'); hold; plot(toutair, vyMair,'-.r'); plot(tout(length(tout)),vyMfinal,'ko');
    title('vyM(t)'); xlabel('t (s)'); ylabel('vyM (m/s)');

    %Ploteamos la trayectoria de M
%     figure;
%     plot(xM, yM,'xb'); 
%     hold; 
%     plot(xMair, yMair,'rx'); 
%     %hold;
%     plot(xMfinal,yMfinal,'ko');

%yair = yair(2:end);

