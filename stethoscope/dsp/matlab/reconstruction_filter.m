% Parámetros del filtro Sallen-Key
R1 = 3.3e3;  % Ω
R2 = 11e3;   % Ω
C1 = 10e-9;  % F
C2 = 15e-9;  % F

% Llamar a la función
H1 = sallen_key_lp(R1, R2, C1, C2, 1);
R1 = 2.2e3;  % Ω
R2 = 5.6e3+560;   % Ω
C1 = 10e-9;  % F
C2 = 33e-9;  % F
H2 = sallen_key_lp(R1, R2, C1, C2, 1);
H=H1*H2;
% Graficar la respuesta en frecuencia
s = tf('s');
H_PB = 1 / (s * 6e3 * 1e-9 + 1);
H_PA = (s * 100e3 * 470e-9) / (s * 100e3 *470e-9  + 1);
bode(H*H_PB*H_PA,opts);
grid on;
title('Diagrama de Bode del Filtro Sallen-Key Pasa Bajas');


% Definir la frecuencia de muestreo
Fs = 8000;  % Frecuencia de muestreo en Hz
Ts = 1 / Fs;  % Período de muestreo




% Convertir el filtro analógico a digital usando Tustin
H_digital = c2d(H, Ts, 'tustin');

% Multiplicar con los filtros digitales
H_final_bowel = series(H_digital, H_total_bowel);
H_final_heart = series(H_digital, H_total_heart);
H_final_lung = series(H_digital, H_total_lung);

% Opciones para la gráfica
opts = bodeoptions;
opts.FreqUnits = 'Hz';  % Mostrar frecuencia en Hz

% Graficar las respuestas en frecuencia
figure;
bode(H_final_bowel, opts);
grid on;
title('Función de transferencia con filtro Bowel pasando por el filtro de reconstrucción');

figure;
bode(H_final_heart, opts);
grid on;
title('Función de transferencia con filtro Heart pasando por el filtro de reconstrucción');

figure;
bode(H_final_lung, opts);
grid on;
title('Función de transferencia con filtro Lung pasando por el filtro de reconstrucción');
