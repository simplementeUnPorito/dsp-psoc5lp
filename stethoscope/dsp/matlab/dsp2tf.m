function H_tf = dsp2tf(H_dsp)
    % Convierte un filtro FIR dsp.FIRFilter a una función de transferencia (tf)
    b = H_dsp.Numerator; % Extrae coeficientes FIR
    a = 1; % FIR es de respuesta finita, por lo que a = 1
    H_tf = tf(b, a, H_dsp.SampleRate); % Crea la función de transferencia discreta
end