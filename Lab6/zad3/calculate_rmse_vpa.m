function [dates, y, rmse_values, M, c_vpa, ya] = calculate_rmse_vpa()
% W tej funkcji obliczenia wykonywane są na zmiennych vpa, jednakże spośród
% zwracanych zmiennych tylko c_vpa jest wektorem zmiennych vpa.
%
% Funkcja calculate_rmse_vpa:
% 1) Wyznacza pierwiastek błędu średniokwadratowego w zależności od stopnia
%    aproksymacji wielomianowej danych przedstawiających produkcję energii.
% 2) Wyznacza i przedstawia na wykresie aproksymację wielomianową wysokiego
%    stopnia danych przedstawiających produkcję energii.
% Dla kraju C oraz źródła energii S:
% dates - wektor energy_2025.C.S.Dates (daty pomiaru produkcji energii)
% y - wektor energy_2025.C.S.EnergyProduction (poziomy miesięcznych produkcji energii)
% rmse_values(i,1) - RMSE wyznaczony dla wektora y i wielomianu stopnia degrees(i)
%     Rozmiar kolumnowego wektora wynosi length(y)-1.
% M - stopień wielomianu aproksymacyjnego przedstawionego na wykresie
% c_vpa - współczynniki wielomianu aproksymacyjnego przedstawionego na wykresie:
%       c = [c_M; ...; c_1; c_0]
% ya - wartości wielomianu aproksymacyjnego wyznaczone dla punktów danych
%       (rozmiar wektora ya powinien być taki sam jak rozmiar wektora y)

    digits(120); % określa liczbę cyfr dziesiętnych w zmiennych vpa

    M = 90; % stopień wielomianu aproksymacyjnego

    load energy_2025;

    dates = energy_2025.USA.Nuclear.Dates; 
    y = energy_2025.USA.Nuclear.EnergyProduction;


        % w Matlab Grader.
    trim = 80;
    if(numel(y)>trim)
        dates = dates(1:trim,1);
        y = y(1:trim,1);
    end

    N = numel(y);

    %degrees = [10, 20];
    %degrees = [N-10, N-1];
    degrees = [N-10, N-1];
    x_vpa = linspace(vpa(0),vpa(1),N)';
    y_vpa = vpa(y);

    rmse_values = zeros(numel(degrees),1);

    % Oblicz RMSE dla każdego stopnia
    for k = 1:length(degrees)
        m = degrees(k);
        d = polyfit_qr_vpa(x_vpa, y_vpa, m);
        d = d(end:-1:1);  % Reverse coefficients to match polyval format
        
        fx = x_vpa;  % No need to copy in a loop
        da = polyval_vpa(d, fx);
        fa = y_vpa;

        rmse = double(sqrt(mean((da - fa).^2)));
        rmse_values(k) = rmse;
    end

    % Aproksymacja wielomianu wysokiego stopnia (dla wykresu)
    c_vpa = polyfit_qr_vpa(x_vpa, y_vpa, M);
    c_vpa = c_vpa(end:-1:1); % odwrócenie kolejności wektora c_vpa: dostosowanie do polyval

    ya = double(polyval_vpa(c_vpa, x_vpa));

    x = double(x_vpa);

    % TODO:
    subplot(2, 1, 1);
    plot(degrees, rmse_values);
    title("RMSE VPA values");
    xlabel("Stopień wielomianu");
    ylabel("RMSE");
    subplot(2, 1, 2);
    plot(dates, y, "r");
    hold on;
    plot(dates, ya, "b");
    hold off;
    legend("Actual", "Approximation");
    title("Aproksymacja wielomianowa z wykorzystaniem VPA");
    xlabel("Wartość x");
    ylabel("Wartość y");
    saveas(gcf, "zadanie3.png");

end


function y = polyval_vpa(coefficients, x)
% Oblicza wartość wielomianu w punktach x dla współczynników coefficients.
% Obliczenia wykonywane są na zmiennych vpa.
% coefficients – wektor współczynników wielomianu w kolejności od najwyższej potęgi
% x – wektor argumentów (zmienne vpa)
% y – wektor wartości wielomianu (zmienne vpa)

    n = length(coefficients);
    y = vpa(zeros(size(x)));  % inicjalizacja wyniku jako vpa

    for i = 1:n
        y = y .* x + coefficients(i);  % schemat Hornera
    end
end



function c_vpa = polyfit_qr_vpa(x, y, M)
    % Wyznacza współczynniki wielomianu aproksymacyjnego stopnia M
    % z zastosowaniem rozkładu QR z użyciem arytmetyki zmiennopozycyjnej (vpa).
    % c_vpa - kolumnowy wektor współczynników: [c_0; ...; c_M]

    digits(120); % ustawienie precyzji obliczeń

    % Konwersja na vpa
    x = vpa(x(:)); % upewnij się, że to kolumna
    y = vpa(y(:));

    % Tworzenie macierzy Vandermonde w sposób wektorowy
    A = vpa(x .^ (0:M));  % każda kolumna to x.^k dla k = 0,...,M

    % Rozkład QR i rozwiązanie układu
    [Q, R] = qr(A, 0);
    c_vpa = R \ (Q' * y);
end