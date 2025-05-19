function [dates, y, rmse_values, M, c, ya] = calculate_rmse()
% 1) Wyznacza pierwiastek błędu średniokwadratowego w zależności od stopnia
%    aproksymacji wielomianowej danych przedstawiających produkcję energii.
% 2) Wyznacza i przedstawia na wykresie aproksymację wielomianową wysokiego
%    stopnia danych przedstawiających produkcję energii.
% Dla kraju C oraz źródła energii S:
% dates - wektor energy_2025.C.S.Dates (daty pomiaru produkcji energii)
% y - wektor energy_2025.C.S.EnergyProduction (poziomy miesięcznych produkcji energii)
% rmse_values(i,1) - RMSE wyznaczony dla wektora y i wielomianu i-tego stopnia
%     Rozmiar kolumnowego wektora wynosi length(y)-1.
% M - stopień wielomianu aproksymacyjnego przedstawionego na wykresie
% c - współczynniki wielomianu aproksymacyjnego przedstawionego na wykresie:
%       c = [c_M; ...; c_1; c_0]
% ya - wartości wielomianu aproksymacyjnego wyznaczone dla punktów danych
%       (rozmiar wektora ya powinien być taki sam jak rozmiar wektora y)

    M = 90; % stopień wielomianu aproksymacyjnego (dla wykresu)

    load energy_2025;

    dates = energy_2025.USA.Nuclear.Dates; 
    y = energy_2025.USA.Nuclear.EnergyProduction;


    N = numel(y);
    degrees = 1:N-1;

    x = linspace(0,1,N)';

    rmse_values = zeros(numel(degrees),1);
    % Oblicz RMSE dla każdego stopnia

    for k = 1:length(degrees)
        m = degrees(k);
        d = polyfit_qr(x, y, m);
        d = d(end:-1:1);  % Reverse coefficients to match polyval format
        
        fx = x;  % No need to copy in a loop
        da = polyval(d, fx);
        fa = y;

        rmse = sqrt(mean((da - fa).^2));
        rmse_values(k) = rmse;

    end

    % Aproksymacja wielomianu wysokiego stopnia (dla wykresu)
    c = polyfit_qr(x, y, M);
    c = c(end:-1:1); % odwrócenie kolejności wektora c: dostosowanie do polyval

    ya = polyval(c, x);



    % TODO:
    subplot(2, 1, 1);
    plot(rmse_values);
    title("RMSE values");
    xlabel("Stopień wielomianu");
    ylabel("RMSE");
    subplot(2, 1, 2);
    plot(dates, y, "r");
    hold on;
    plot(dates, ya, "b");
    hold off;
    legend("Actual", "Approximation");
    title("Aproksymacja wielomianowa");
    xlabel("Wartość x");
    ylabel("Wartość y");
    saveas(gcf, "zadanie2.png");
end


function c = polyfit_qr(x, y, M)
    % Wyznacza współczynniki wielomianu aproksymacyjnego stopnia M
    % z zastosowaniem rozkładu QR.
    % c - kolumnowy wektor wsp. wielomianu c = [c_0; ...; c_M]

    N = numel(x);
    A = ones(N ,M+1); % macierz Vandermonde o rozmiarze [n,M+1]
    
    
    for i = 1:N
        for j = 2:M+1
            A(i, j) = x(i)^(j - 1);
        end
    end

    [q1, r1] = qr(A, 0);
    c = r1\ (q1.' * y);

end