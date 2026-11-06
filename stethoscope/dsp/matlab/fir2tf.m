function H_tf = fir2tf(H_fir, Fs)
    b = H_fir.Numerator;  % Coeficientes del numerador
    a = 1;  % Coeficientes del denominador para FIR
    H_tf = tf(b, a, 1/Fs, 'Variable', 'z^-1');  % Crear función de transferencia digital
end