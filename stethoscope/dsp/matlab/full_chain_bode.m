% Definir la frecuencia de muestreo de los filtros digitales
Fs = 8000;  % 8 kHz, asegúrate de que coincide con la de H_final_heart, H_final_lung, etc.
Ts = 1 / Fs;  % Período de muestreo

% Convertir LM386conZobelNetwork a un sistema discreto con Tustin
LM386conZobelNetwork_d = c2d(LM386conZobelNetwork, Ts, 'tustin');

% Multiplicar los sistemas discretizados
H_output_heart = series(LM386conZobelNetwork_d, H_final_heart);
H_output_lung = series(LM386conZobelNetwork_d, H_final_lung);
H_output_bowel = series(LM386conZobelNetwork_d, H_final_bowel);

% Configuración de gráficos en Hz
opts = bodeoptions;
opts.FreqUnits = 'Hz';

% Graficar la respuesta en frecuencia de cada sistema combinado
figure;
bode(LM386conZobelNetwork, opts);
grid on;
title('Función del amplificador de audio');
xlim([1,4e3]);
figure;
bode(H_output_heart, opts);
grid on;
title('Función de transferencia con del circuito final con filtro Heart');
xlim([1,4e3]);
figure;
bode(H_output_lung, opts);
grid on;
title('Función de transferencia con del circuito final con filtro Lung');
xlim([1,4e3]);
figure;
bode(H_output_bowel, opts);
grid on;
title('Función de transferencia con del circuito final con filtro Bowel');
xlim([1,4e3]);