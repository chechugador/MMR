# MMR
Study, development and validation of a novel  leg model for legged quadruped robots.
------------------------------------------------------------------------------------

Repositorio con el desarrollo, simulación y validación del modelo MMR (Masa-Masa-Resorte).

La simulación ha sido desarrollada con MATLAB y Simulink y la obtención de datos de trayectorias
reales se ha realizado con el programa open-source de análisis de vídeo Tracker.

IMPORTANTE:
-----------------------------------------------------------------------------------------------
Se recomienda añadir al Path de MATLAB todos los directorios y subdirectorios del repositorio,
para evitar complicaciones.
Para correr la simulacion, es necesario abrir los siguientes archivos de Simulink:
  - Matlab\Modelo SLIP\slip_ground.slx
  - Matlab\Modelo SLIP\slip_air.slx
  - Matlab\Modelo MMR\mmr_ground.slx
  - Matlab\Modelo MMR\mmr_air_alternat.slx
Además, habrá que abrir los dos siguientes archivos en MATLAB:
  - Matlab\Modelo SLIP\trayectoriaSLIP.m
  - Matlab\Modelo SLIP\trayectoriaMMR.m
y modificar en ellos el Path donde se encuentra el directorio 'Videos Tracker'
------------------------------------------------------------------------------------------------
EJECUCIÓN:
-----------------------------------------------------------------------------------------------
Una vez realizadas estas acciones, se puede proceder a ejecutar la simulación:

1) Abrir el script SLIPvsMMR.m
2) Especificar en las lineas 11 y 25 la trayectoria que se quiere simular:
  - 'hop'
  - 'cheetah'
  - 'caballo1', 'caballo2', 'caballo3'
  - 'canguro1', 'canguro2', 'canguro3'
3) Ejecutar el script SLIPvsMMR.m

-----------------------------------------------------------------------------------------------
