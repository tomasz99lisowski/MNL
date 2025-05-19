function [dates, y, M, c, ya] = test_approximation()
% Wyznacza aproksymację wielomianową danych przedstawiających produkcję energii.
% Dla kraju C oraz źródła energii S:
% dates - wektor energy_2025.C.S.Dates (daty pomiaru produkcji energii)
% y - wektor energy_2025.C.S.EnergyProduction (poziomy miesięcznych produkcji energii)
% M - stopień wielomianu aproksymacyjnego
% c - współczynniki wielomianu aproksymacyjnego: c = [c_M; ...; c_1; c_0]
% ya - wartości wielomianu aproksymacyjnego wyznaczone dla punktów danych
%       (rozmiar wektora ya powinien być taki sam jak rozmiar wektora y)

    load energy_2025;


    dates = energy_2025.Germany.Wind.Dates; % dates = energy_2025.C.S.Dates; % TODO
    y = energy_2025.Germany.Wind.EnergyProduction; % TODO

    M = 12; % stopień wielomianu aproksymacyjnego

    N = numel(y); % liczba danych
    x = linspace(0,1,N)'; % znormalizowana dziedzina aproksymowanych danych

    c = polyfit_qr(x,y,M); % wsp. wielomianu 

    c = c(end:-1:1); % odwrócenie kolejności elementów wektora c; dostosowanie do polyval

    ya = polyval(c,x); % wyznaczenie wartości wielomianu aproksymacyjnego

    % TODO:
    % wykres

    plot(dates, y, "r");
    hold on;
    plot(dates, ya, "b");
    hold off;
    legend("Actual", "Approximation");
    title("Aproksymacja wielomianowa");
    xlabel("Data");
    ylabel("Produkcja energii");
    saveas(gcf, "zadanie1.png");
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