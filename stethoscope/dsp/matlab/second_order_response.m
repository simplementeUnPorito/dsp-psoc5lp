
% Parámetros
f_r = 5e3; % Frecuencia de resonancia (Hz)
f_L = 8; % Frecuencia de corte inferior (Hz)
f_H = 7.5e3; % Frecuencia de corte superior (Hz)
M_r = 10; % Pico de resonancia
gain_db = 40; % Ganancia en frecuencias medias (dB)
K = 10^(gain_db / 20); % Ganancia en lineal

% Frecuencias en rad/s
omega_r = 2 * pi * f_r; % Frecuencia de resonancia (rad/s)
omega_L = 2 * pi * f_L; % Frecuencia de corte inferior (rad/s)
omega_H = 2 * pi * f_H; % Frecuencia de corte superior (rad/s)

% Cálculo del factor de amortiguamiento (zeta)
zeta = 1 / (2 * M_r * sqrt(1 - (1 / (2 * M_r^2))));

% Cálculo de la frecuencia natural (omega_n)
omega_n = omega_r / sqrt(1 - 2 * zeta^2);

% Verificación de que el sistema pasa por las frecuencias deseadas
disp('Verificación de frecuencias:');
disp(['Frecuencia natural calculada: ', num2str(omega_n / (2 * pi)), ' Hz']);
disp(['Factor de amortiguamiento (zeta): ', num2str(zeta)]);

% Función de transferencia: Ganancia centrada en la resonancia
numerador = [K * omega_n^2 , 1]/omega_L; % Numerador
denominador = conv([1, 2 * zeta * omega_n, omega_n^2],[1/omega_L 1]); % Denominador
sys = tf(numerador, denominador);

% Graficar el diagrama de Bode
figure;
bode(sys, {2*pi*f_L, 2*pi*f_H}); % Mostrar entre las frecuencias de corte
grid on;
title('Diagrama de Bode del sistema de segundo orden');

% Mostrar valores calculados
disp('Parámetros del sistema:');
disp(['Factor de amortiguamiento (zeta): ', num2str(zeta)]);
disp(['Frecuencia natural (omega_n): ', num2str(omega_n / (2 * pi)), ' Hz']);
disp(['Ganancia (K): ', num2str(K)]);
