% Newtonova metoda pre aproximaciu celkovej variancie odsumovania signalu

% nacitanie dat
approx_tv_denoising_data;

% dvojdiagonalna matica, zvysok su 0
D = spdiags([-1*ones(n,1) ones(n,1)], 0:1, n-1, n);

% Newtonova metoda
max_iter = 100;
tolerancia = 1e-10;
x = zeros(n,1);
dlzka_kroku = [];
alfa = 0.01;
beta = 0.5;

for iteracia = 1:max_iter
    d = D * x;
    Fval = (x-xcor)' * (x-xcor) + lambda * sum(sqrt(epsilon^2 + d.^2) - epsilon * ones(n-1,1));
    gradient = 2 * (x - xcor) + lambda * D' * (d ./ sqrt(epsilon^2 + d.^2));
    hesian = 2 * speye(n) + lambda * D' * spdiags( epsilon^2 * (epsilon^2 + d.^2).^(-3/2),0,n-1,n-1) * D;
    lambda_squared = -gradient' * (-hesian \ gradient);
    dlzka_kroku = [dlzka_kroku sqrt(lambda_squared)];
    if (lambda_squared / 2) < tolerancia
        break;
    end;
    %backtracking na urcenie optimalnej dlzky kroku
    krok = 1;
    while ((x + krok * (-hesian \ gradient) - xcor)' * (x + krok * (-hesian \ gradient) - xcor) + lambda * sum( sqrt( epsilon^2 + (D * (x + krok * (-hesian \ gradient))).^2) - epsilon * ones(n-1,1)) > Fval - alfa * krok * lambda_squared )
        krok = beta * krok;
    end;
    x = x + krok * (-hesian \ gradient);
end;

% vykreslenie vysledkov
figure;
semilogy([1:iteracia],dlzka_kroku,'*-');
xlabel('iterácie');
ylabel('dĺžka kroku');
title('Dĺžka kroku pri rastúcom počte iterácií');
grid on;

figure;
cas = 1:5000;
plot(cas,x,'g','LineWidth',3)
hold on
plot(cas,xcor,'r:','LineWidth',1)
xlabel('t');
legend('x(t)','xcor(t)');
title('Poškodený signál vs vypočítaný signál');
hold off
