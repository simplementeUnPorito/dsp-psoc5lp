function H_sallen_key = sallen_key_lp(R1, R2, C1, C2,K)
    % Variable de Laplace
    s = tf('s');


    % Numerador y denominador de la función de transferencia
    num = K;
    den = [R1 * R2 * C1 * C2, (R1 * C1 + R2 * C1 + R1 * C2 * (1 - K)), 1];

    % Crear la función de transferencia
    H_sallen_key = tf(num, den);
end
