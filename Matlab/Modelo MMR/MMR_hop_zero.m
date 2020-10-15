%Se realiza en este script el modelado cinemático y dinámico del sistema
%masa-masa-resorte en péndulo invertido para el movimiento de salto
%estático (hopping at zero forward speed). Valores de ctes obtenidos
%de disecciones del cheetah

g=9.81;
M=15;
m=3;
k=200;
Lhk=0.28;   %Longitud de cadera a rodilla (fémur)
Lkf=0.28;   %Longitud de rodilla a pie (tibia)
y0 = Lhk + Lkf; %Posicion inicial del CoM del tronco
%y0 = 0;

w = sqrt(k / (M + m));  %Frecuencia mecánica

%La x es cte, dado que no hay velocidad horizontal. Se dispone, por tanto,
%de una única ecuación en y.
%
%   (M+m)*y'' + k*y = (M+m)*g 
%

%Ademas, debe cumplirse que vy(t=tc/2)=0, asi que
% vy0 = - g * w * tan(w*tc/2);
%Finalmente, durante la aerial phase (M+m)y'' = (M+m)g
%Es decir, vy0 = g*ta/2;
%Ademas, el tiempo total es T = ta + tc. Donde f = 1/T;
f = 2;  %Frecuencia en Hz
T = 1/f;
tc = 0.75 * T;
ta = T - tc;
vy0 = - g * ta / 2;
% Para tc = ta = 0.25 -> w = 35.94 / 61.80 / 87.23 / 112.53
% Para tc = 0.375; ta = 0.125 -> w = 21.75 / 39.85 / 57.19 
% Para tc = 0.125; ta = 0.375 -> w = 21.19 / 74.25 / 124.98 / 175.44 /
% 276.15
% Para tc = 0.125; ta = 0.125 -> w = 
w = 21.75;
k = w * w * (M + m);

%La solucion es del tipo y(t) = a*sin(w*t) + b*cos(w*t) + cte

%Conds de contorno 
% 1) y(t=0) = y0
% 2) y'(t=0) = v0
%
%Se obtiene cte = yo + g/w/w; b = -g/w/w; a = v0/w;
cte = y0 + g/w/w;
b = -g/w/w;
a = vy0/w;
%Finalmente y = v0*sen(wt)/w - g*w*w*cos(wt) + y0 + g*w*w;

%Ejecutamos el bloque de simulink con la ec dif
sim('hop_zero_ground');
out=ans;
y = out.y;
vy = out.vy;
tGround = y(:,1);
y = y(:,2);
vy = vy(:,2);
yfinal = y( length(y) );
vyfinal = vy( length(vy) );

subplot(2,2,1);
plot(tGround,y);
title('Posicion en fase Ground'); xlabel('t (s)'); ylabel('y (m)');
subplot(2,2,3);
plot(tGround,vy);
title('Velocidad en fase Ground'); xlabel('t (s)'); ylabel('vy (m/s)');

sim('hop_zero_aerial');
tAerial = ans.yAerial(:,1);
yAerial = ans.yAerial(:,2);
vyAerial = ans.vyAerial(:,2);

subplot(2,2,2);
plot(tAerial,yAerial);
title('Posicion en fase aérea'); xlabel('t (s)'); ylabel('y (m)');
subplot(2,2,4);
plot(tAerial,vyAerial);
title('Velocidad en fase aérea'); xlabel('t (s)'); ylabel('vy (m/s)');

%Finalmente y = v0*sen(wt)/w - g*w*w*cos(wt) + y0 + g*w*w;
yTeorica = vy0 * sin(w*tGround) / w - g/w/w * cos(w*tGround) + y0 + g/w/w;
figure;
plot(tGround, yTeorica);


