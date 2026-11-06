clc; clear; close all;

% Parámetros del filtro
fs = 8000;  % Frecuencia de muestreo (Hz)
N = 128;    % Orden del filtro
fc1 = 100;  % Frecuencia de corte baja (Hz)
fc2 = 1000; % Frecuencia de corte alta (Hz)

% Normalización de frecuencias de corte
Wn = [fc1 fc2] / (fs / 2); 

% Ventanas a comparar
windows = {
    {'Rectangular', rectwin(N+1)}, 
    {'Hamming', hamming(N+1)}, 
    {'Hanning', hanning(N+1)}, 
    {'Blackman', blackman(N+1)}, 
    {'Kaiser, β=5', kaiser(N+1, 5)}, 
    {'Kaiser, β=8', kaiser(N+1, 8)}
};

% Diseño del filtro Park-McClellan (Remez Exchange)
f_bands = [0 fc1 fc1 fc2 fc2 fs/2] / (fs/2);  % Frecuencias de bandas (normalizadas)
a_desired = [0 0 1 1 0 0];  % Respuesta deseada (banda de paso en [fc1, fc2])
weights = [10 1 10];  % Peso para mejorar la equirriplez

b_pm = firpm(N, f_bands, a_desired, weights);  % Diseño con Park-McClellan

% Figura para la respuesta en frecuencia
figure;
hold on;

% Comparar ventanas
for i = 1:length(windows)
    win_name = windows{i}{1};
    win = windows{i}{2};
    
    % Diseño del filtro FIR usando la ventana actual
    b = fir1(N, Wn, 'bandpass', win);
    
    % Obtener la respuesta en frecuencia
    [H, f] = freqz(b, 1, 1024, fs);
    
    % Graficar la magnitud en dB
    plot(f, 20*log10(abs(H)), 'DisplayName', win_name);
end

% Agregar el filtro de Park-McClellan a la comparación
[H_pm, f] = freqz(b_pm, 1, 1024, fs);
plot(f, 20*log10(abs(H_pm)), 'k--', 'LineWidth', 1.5, 'DisplayName', 'Park-McClellan');

% Configuración del gráfico
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (dB)');
title('Comparación de Filtros FIR: Ventanas vs. Park-McClellan');
legend;
grid on;
hold off;
