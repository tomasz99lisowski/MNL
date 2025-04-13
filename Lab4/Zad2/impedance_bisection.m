function [xvec,xdif,xsolution,ysolution,iterations] = impedance_bisection()
% Wyznacza miejsce zerowe funkcji impedance_difference metodą bisekcji.
% xvec - wektor z kolejnymi przybliżeniami miejsca zerowego, gdzie xvec(1)= (a+b)/2
% xdif - wektor różnic kolejnych przybliżeń miejsca zerowego
%   xdif(i) = abs(xvec(i+1)-xvec(i));
% xsolution - obliczone miejsce zerowe
% ysolution - wartość funkcji impedance_difference wyznaczona dla f=xsolution
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution

a = 1; % lewa granica przedziału poszukiwań miejsca zerowego
b = 10; % prawa granica przedziału poszukiwań miejsca zerowego
ytolerance = 1e-12; % tolerancja wartości funkcji w przybliżonym miejscu zerowym.
% Warunek abs(f1(xsolution))<ytolerance określa jak blisko zera ma znaleźć
% się wartość funkcji w obliczonym miejscu zerowym funkcji f1(), aby obliczenia
% zostały zakończone.
max_iterations = 1000; % maksymalna liczba iteracji wykonana przez alg. bisekcji

fa = impedance_difference(a);
fb = impedance_difference(b);

xvec = [];
xdif = [];
xsolution = Inf;
ysolution = Inf;
iterations = max_iterations;

for ii=1:max_iterations
    c = (a+b)/2;
    xvec(ii,1) = c;
    fc = impedance_difference(c);
    if ii > 1
        xdif(ii-1, 1) = abs(xvec(ii) - xvec(ii-1));
    end

    if(abs(fc)<ytolerance)
        xsolution = c;
        ysolution = fc;
        iterations = ii;
        break
    elseif (impedance_difference(a)*impedance_difference(c)<0)
        b = c;
    else
        a = c;
    end

end

subplot(2, 1, 1)
plot(xvec)
title("Values of X");
xlabel('Iteration');
ylabel('Value of X');
subplot(2, 1, 2)
semilogy(xdif)
title("Absolute differneces between X values");
xlabel('Iteration');
ylabel('Difference');
saveas(gcf,'xdif_xvec.png');
end

function [impedance_delta] = impedance_difference (frequency)

R = 525;
C = 7e-5;
L = 3;
M = 75;

if frequency < 0
    error('Frequency must be a positive number')
end

module = 1/sqrt((1/(R^2)) + (2*pi*frequency*C - 1/(2*pi*frequency*L))^2);
impedance_delta = module - M;

end

