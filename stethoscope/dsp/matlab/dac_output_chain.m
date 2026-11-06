% Paso 1: Definir la frecuencia de muestreo
Fs = 8000;  % Frecuencia de muestreo en Hz
Ts = 1 / Fs;  % Período de muestreo

% Paso 2: Convertir linsys1 a un sistema digital
linsys1_d = c2d(linsys1, Ts, 'tustin');



% Convertir cada filtro
Hbowel_tf = fir2tf(Hbowel, Fs);
Hheart_tf = fir2tf(Hheart, Fs);
Hlung_tf = fir2tf(Hlung, Fs);

% Paso 4: Combinar los sistemas digitales
H_total_bowel = series(linsys1_d, Hbowel_tf);
H_total_heart = series(linsys1_d, Hheart_tf);
H_total_lung = series(linsys1_d, Hlung_tf);

% Paso 5: Visualizar la respuesta en frecuencia
opts = bodeoptions;
opts.FreqUnits = 'Hz';  % Establecer unidades de frecuencia en Hz

figure;
bode(linsys1_d,opts);
title('Bode de Antialias Digitalizado');
grid on;
figure;
hold on;
bode(Hbowel_tf, opts);
bode(Hheart_tf, opts);
bode(Hlung_tf, opts);
title('Bode de Filtros Digitales');
grid on;


figure;
bode(H_total_bowel, opts);
title('Bode de antialias digitalizado * Hbowel');
grid on;

figure;
bode(H_total_heart, opts);
title('Bode de antialias digitalizado * Hheart');
grid on;

figure;
bode(H_total_lung, opts);
title('Bode de antialias digitalizado * Hlung');
grid on;

% Paso 3: Convertir los filtros dsp.FIRFilter a funciones de transferencia digitales
% Función auxiliar para convertir dsp.FIRFilter a tf

