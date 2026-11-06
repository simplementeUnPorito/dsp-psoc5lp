close all
clear all
clc

% Definición de la función de impedancia en paralelo
paralelo = @(Z1, Z2) (Z1 .* Z2) / (Z1 + Z2);

% Sistema de transferencia
s = tf('s');
H = 20 / (s / (2 * pi * 300e3) + 1);

% Obtener los datos de Bode para H
[mag_H, phase_H, omega_H] = bode(H);
freq_H = omega_H / (2 * pi); % Convertir frecuencia a Hz

% Graficar H
figure;
subplot(2, 1, 1);
semilogx(freq_H, 20*log10(squeeze(mag_H))); % Magnitud en dB
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
title('Magnitude Response of H');

subplot(2, 1, 2);
semilogx(freq_H, squeeze(phase_H)); % Fase en grados
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
title('Phase Response of H');

% Sistema Hf
Hf = 2 * paralelo(15e3, 1 / (s * 100e-9) + 1e3) / ((150 + 1.35e3) * (s / (2 * pi * 300e3) + 1));
[mag_Hf, phase_Hf, omega_Hf] = bode(Hf);
freq_Hf = omega_Hf / (2 * pi);

% Graficar Hf
figure;
subplot(2, 1, 1);
semilogx(freq_Hf, 20*log10(squeeze(mag_Hf))); % Magnitud en dB
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
title('Magnitude Response of Hf');

subplot(2, 1, 2);
semilogx(freq_Hf, squeeze(phase_Hf)); % Fase en grados
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
title('Phase Response of Hf');

% Sistema Hg
Hg = 2 * 15e3 / ((150 + paralelo(1.35e3, -1.93e3)) * (s / (2 * pi * 300e3) + 1));
[mag_Hg, phase_Hg, omega_Hg] = bode(Hg);
freq_Hg = omega_Hg / (2 * pi);

% Graficar Hg
figure;
subplot(2, 1, 1);
semilogx(freq_Hg, 20*log10(squeeze(mag_Hg))); % Magnitud en dB
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
title('Magnitude Response of Hg');

subplot(2, 1, 2);
semilogx(freq_Hg, squeeze(phase_Hg)); % Fase en grados
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
title('Phase Response of Hg');

% Sistema Hpro
Hpro = 2 * paralelo(15e3, 1 / (s * 100e-9) + 1e3) / ((150 + paralelo(1.35e3, -1.93e3)) * (s / (2 * pi * 300e3) + 1));
[mag_Hpro, phase_Hpro, omega_Hpro] = bode(Hpro);
freq_Hpro = omega_Hpro / (2 * pi);

% Graficar Hpro
figure;
subplot(2, 1, 1);
semilogx(freq_Hpro, 20*log10(squeeze(mag_Hpro))); % Magnitud en dB
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
title('Magnitude Response of Hpro');

subplot(2, 1, 2);
semilogx(freq_Hpro, squeeze(phase_Hpro)); % Fase en grados
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
title('Phase Response of Hpro');
