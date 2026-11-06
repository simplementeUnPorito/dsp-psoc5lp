%% limpiar

clear all
close all
clc

%% Chebyshev

% Parámetros del filtro Chebyshev
fs = 44.1e3;       % Frecuencia de muestreo (Hz)
N = 6;             % Orden del filtro
fc = 5e3;          % Frecuencia central (Hz)
BW = 2e3;          % Ancho de banda (Hz)
Rp = 1;            % Ripple en la banda de paso (dB)

% Frecuencias normalizadas
w = [fc-BW/2, fc+BW/2] / (fs/2);

% Diseño del filtro Chebyshev tipo I
[Bc, Ac] = cheby1(N, Rp, w, 'bandpass');
[sos,g] = tf2sos(Bc,Ac);
% Visualización de la respuesta en frecuencia
fvtool(Bc, Ac, 'Fs', fs);
title('Filtro Paso Banda Chebyshev - IIR');

% Pausa hasta que el usuario presione Enter
disp('Presione Enter para continuar...');
input('');

%% Parks-McClellan

% Parámetros del filtro FIR Parks-McClellan
fp1 = 4e3;         % Frecuencia de inicio de la banda de paso (Hz)
fp2 = 6e3;         % Frecuencia de fin de la banda de paso (Hz)
fs1 = 2e3;         % Frecuencia de fin de la banda de parada baja (Hz)
fs2 = 8e3;         % Frecuencia de inicio de la banda de parada alta (Hz)
Rp = 0.15;         % Rizado en la banda de paso (dB)
Rs = 55;           % Atenuación en la banda de parada (dB)

% Frecuencias normalizadas
frequencies = [fs1, fp1, fp2, fs2];

% Amplitudes deseadas en cada banda
amplitudes = [0, 1, 0];

% Pesos relativos de las bandas
weights = [10^(-Rs/20), 1-10^(-Rp/20), 10^(-Rs/20)];

% Cálculo del orden del filtro
[n, fo, ao, w] = firpmord(frequencies, amplitudes, weights, fs);

% Forzar un orden mínimo si es necesario
n = n + mod(n, 2);  % el orden debe ser par
n = max(n,3);
options = [50, 0]; % [MaxIterations, GridDensity]
% Diseño del filtro FIR
Bf = firpm(n, fo, ao, w);

% Visualización de la respuesta en frecuencia
fvtool(Bf, 1, 'Fs', fs);
title('Filtro Paso Banda FIR - Parks-McClellan');
