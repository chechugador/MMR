%%
% En este script se realiza la comparacion entre los modelos SLIP y
% MMR. Los datos de entrada se toman de las trayectorias generadas
% con Tracker  de videos de un Cheetah, un caballo o un canguro.
clear; clear global; close all;
global alfaSlip;
global alfaSlipAir;
global tracks;
%%
% 1) Se obtienen las inputs para el modelo SLIP
[alfaSlip alfaSlipAir tracks] = trayectoriaSLIP('cheetah');
%%
%alfaSlip = alfaSlip * (-1);
%alfaSlipAir = alfaSlipAir * (-1);
% 2) Simular modelo SLIP con los datos obtenidos
alfa0 = alfaSlip(1);
SLIP;
%%
clear; clear global;
global tracks;
global alfaMMR;
global betaMMR;
global alfaAirMMR; global betaAirMMR;
% 3) Se obtienen las Inputs del modelo MMR
[alfaMMR betaMMR alfaAirMMR betaAirMMR tracks] = trayectoriaMMR('cheetah');
% betaMMR = alfaMMR - alfaMMR;
% betaAirMMR = alfaAirMMR - alfaAirMMR;
%alfaMMR = alfaMMR * (-1);
%alfaAirMMR = alfaAirMMR * (-1);
alfa0 = alfaMMR(1);
beta0 = betaMMR(1);
%%
% 4) Simular modelo MMR con los datos obtenidos
MMR;