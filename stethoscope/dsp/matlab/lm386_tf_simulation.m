
% Definir variable de Laplace
s = tf('s');

% Parámetros de la ganancia
R1 = 15e3; % 15kΩ
R2 = 150;
R3 = 1.35e3;
Rf = 39e3; % 1.5kΩ
Cf = 1e-9; % Ejemplo de Cf, ajustable


% Parámetros de los filtros
Rin = 50e3; % 50kΩ
CPA = 470e-9; % 470nF (Pasa-altas)
CPB = 2e-9; % 2nF (Pasa-bajas)

% Modelado de la ganancia del amplificador
Zf = (1/(s*Cf) + Rf); % Impedancia del lazo de realimentación
Z1 = (R1 * Zf) / (R1 + Zf); % Paralelo entre 15k y Zf
Gain = 2*Z1/(R2+R3);
% Filtro pasa-altas en la entrada
H_PA = (s * Rin * CPA) / (s * Rin * CPA + 1);

% Filtro pasa-bajas en la entrada
H_PB = 1 / (s * Rin * CPB + 1);

% Función de transferencia total del LM386
H_LM386 = Gain * H_PA * H_PB;

% Opciones de Bode en Hz
opts = bodeoptions;
opts.FreqUnits = 'Hz';

% Graficar la respuesta en frecuencia
figure;
hold on;
bode(H_LM386,H_PA,H_PB,Gain, opts);





grid on;
title('Diagrama de Bode del LM386');
[H_LM386n, H_LM386d] = tfdata(H_LM386, 'v'); 
