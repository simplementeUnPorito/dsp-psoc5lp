clear; clc; close all;

s = tf('s');

% Parámetros fijos
Rs = 4.45;
Ls = 2.2949e-3;
Cc = 6600e-6;
Rz_values = [4.4, 4.7];
Cz_values = [66e-6, 100e-6, 115e-6, 133e-6, 150e-6];

% Frecuencia de análisis
f = logspace(-1, 5, 1000); % De 0.1 Hz a 1 kHz
w = 2 * pi * f; % Convertir a rad/s

figure;
for i = 1:length(Rz_values)
    Rz = Rz_values(i);
    subplot(length(Rz_values), 1, i);
    hold on;
    yline(Rz, 'k--', sprintf('%.1f Ω', Rz), 'LabelHorizontalAlignment', 'left','DisplayName',sprintf('Rz = %.1f Ω', Rz));
    for Cz = Cz_values
        % Impedancias en forma de funciones de transferencia
        Z1 = Rz + 1/(s*Cz);
        Z2 = 1/(s*Cc) + Rs + s*Ls;
        Z_total = Z1 * Z2 / (Z1 + Z2);
        
        % Obtener la magnitud de Z_total
        [mag,~,wout] = bode(Z_total, w);
        mag = squeeze(mag);
        freq = wout / (2*pi); % Convertir rad/s a Hz
        
        % Graficar la impedancia total
        loglog(freq, mag, 'DisplayName', sprintf('Z_{total} Cz = %.1f uF', Cz*1e6));
        
        % Encontrar picos máximos
        [picos_max, locs_max] = findpeaks(mag, freq);
        plot(locs_max, picos_max, 'ro', 'MarkerFaceColor', 'r','DisplayName',sprintf('Max(%.1f,%.1f)',picos_max,locs_max)); % Máximos en rojo
        
        % Mostrar el valor de frecuencia y amplitud en el gráfico
        for j = 1:length(locs_max)
            text(locs_max(j), picos_max(j), sprintf('%.1f Hz\n%.1f Ω', locs_max(j), picos_max(j)), ...
                'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 8, 'Color', 'r');
        end
        
        % Encontrar picos mínimos (invirtiendo la señal)
        [picos_min, locs_min] = findpeaks(-mag, freq);
        picos_min = -picos_min; % Revertir signo para obtener el valor correcto
        
        plot(locs_min, picos_min, 'bo', 'MarkerFaceColor', 'b','DisplayName',sprintf('Min(%.1f,%.1f)',picos_min,locs_min)); % Mínimos en azul
        
        % Mostrar el valor de frecuencia y amplitud en el gráfico
        for j = 1:length(locs_min)
            text(locs_min(j), picos_min(j), sprintf('%.1f Hz\n%.1f Ω', locs_min(j), picos_min(j)), ...
                'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'FontSize', 8, 'Color', 'b');
        end
        hold on;
    end
    hold off;
    grid on;
    xlabel('Frecuencia (Hz)');
    ylabel('Impedancia (Ω)');
    title(sprintf('Diagrama de Impedancia - Z_{total} para Rz = %.1f Ω', Rz));
    ylim([3, 6]); % Ajusta el eje Y de 10^4 a 10^5
    legend show;
    set(gca, 'YScale', 'log'); % Asegura escala logarítmica en X
    set(gca, 'XScale', 'log'); % Asegura escala logarítmica en X
end
set(gca, 'XScale', 'log'); % Eje X logarítmico
set(gca, 'YScale', 'log'); % Eje Y logarítmico