

% Definir variable simbólica s para funciones de transferencia
s = tf('s');

% Definir función anónima del filtro Sallen-Key pasa bajas
H_sallen_key = @(R1, R2, C1, C2, K) tf([K], [R1 * R2 * C1 * C2, (R1 * C1 + R2 * C1 + R1 * C2 * (1 - K)), 1]);

% Parámetros del filtro reconstruccion
R1_1 = 3.3e3;  % Ω
R2_1 = 11e3;   % Ω
C1_1 = 10e-9;  % F
C2_1 = 15e-9;  % F

R1_2 = 2.2e3;  % Ω
R2_2 = 6.2e3;  % Ω
C1_2 = 10e-9;  % F
C2_2 = 33e-9;  % F

% Calcular funciones de transferencia de cada etapa del filtro
H1 = H_sallen_key( R1_1, R2_1, C1_1, C2_1, 1);
H2 = H_sallen_key( R1_2, R2_2, C1_2, C2_2, 1);

% Función de transferencia total del filtro reconstruccion (producto de las dos etapas)
Hreco = H1 * H2;


% Parámetros del filtro antialias
R1_1 = 33e3;  % Ω
R2_1 = 110e3;   % Ω
C1_1 = 1e-9;  % F
C2_1 = 1.5e-9;  % F

R1_2 = 22e3;  % Ω
R2_2 = 62e3;  % Ω
C1_2 = 1.0e-9;  % F
C2_2 = 3.3e-9;  % F


% Calcular funciones de transferencia de cada etapa del filtro
H1 = H_sallen_key( R1_1, R2_1, C1_1, C2_1, 1);
H2 = H_sallen_key( R1_2, R2_2, C1_2, C2_2, 1);

% Función de transferencia total del filtro reconstruccion (producto de las dos etapas)
Hantialias = H1 * H2;


Centrada = 0.33e-6;
Rentrada = 470e3;
HpasivoEntrada = tf([Centrada*Rentrada,0],[Centrada*Rentrada,1]);

R1 = 4e3;
C1 = 10e-9;
R2 = 110e3;
C2 = 470e-9;

HpasivoSalida = tf([R2*C2,0],[R2*C2,1])*tf([1],[C1*R1,1]);













H = HpasivoEntrada*Hantialias*HpasivoSalida*HpasivoEntrada*Hreco;
Ha = c2d(H, 1/8000, 'tustin');
opts = bodeoptions('cstprefs'); % Obtener opciones de Bode
opts.FreqUnits = 'Hz';  % Cambiar unidades de frecuencia a Hz
opts.Grid = 'on';       % Activar la cuadrícula
% Graficar respuesta en frecuencia del filtro antialiasing

% Convertir FIRFilter a tf
Hbowel_tf = tf(Hbowel); 
Hlung_tf = tf(Hlung); 
Hheart_tf = tf(Hheart); 
figure;
bode(Ha*Hbowel_tf,opts);
title('Diagrama de Bode del Filtro Bowel');
grid on;
figure;
bode(Ha*Hheart,opts);
title('Diagrama de Bode del Filtro Heart');
grid on;

figure;
bode(Ha*Hlung,opts);
title('Diagrama de Bode del Filtro Lung');
grid on;

