function [ft_5, yrmax, Nt, xr, yr, integration_error] = monte_carlo_accuracy_evaluation()
    % Numeryczne całkowanie metodą Monte Carlo.
    %
    % ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    %
    % yrmax - maksymalna dopuszczalna wartość współrzędnej y losowanych punktów
    %
    % Nt - wektor wierszowy zawierający liczby losowań, dla których obliczano
    %     wektor błędów całkowania integration_error.
    %
    % [xr, yr] - tablice komórkowe zawierające informacje o wylosowanych punktach.
    %     Tablice te mają rozmiar [1, length(Nt)]. W komórkach xr{1,i} oraz yr{1,i}
    %     zawarte są współrzędne x oraz y wszystkich punktów zastosowanych
    %     do obliczenia całki przy losowaniu Nt(1,i) punktów.
    %
    % integration_error - wektor wierszowy. Każdy element integration_error(1,i)
    %     zawiera błąd całkowania obliczony dla liczby losowań równej Nt(1,i).
    %     Zakładając, że obliczona wartość całki dla Nt(1,i) próbek wynosi
    %     integration_result, błąd jest definiowany jako:
    %     integration_error(1,i) = abs(integration_result - reference_value),
    %     gdzie reference_value to wartość referencyjna całki.

    reference_value = 0.0473612919396179; % wartość referencyjna całki

    ft_5 = failure_density_function(5);
    xrmax = 5;
    yrmax = ft_5 + rand() * ft_5;


    Nt = 5:50:10^4;
    xr = [];
    yr = [];

    for i = 1:length(Nt)
        N = Nt(i);
        x = linspace(0,5,N+1);


        [val, xrand, yrand] = monte_carlo_integral(N, xrmax, yrmax);
        xr{1, i} = xrand;
        yr{1, i} = yrand;
        integration_error(1, i) = abs(val - reference_value);
    end

    loglog(Nt, integration_error);
    xlabel("Liczba przedziałów");
    ylabel("Błąd");
    legend("Liczba przedziałów", "Błąd");
    title("Metoda Monte Carlo");
    saveas(gcf, "zadanie4.png");


end

function [integral_approximation, x, y] = monte_carlo_integral(N, xmax, ymax)
    % Oblicza przybliżoną wartość całki oznaczonej z funkcji gęstości
    % prawdopodobieństwa (failure_density_function) przy użyciu
    % metody Monte Carlo.
    %
    % N – liczba losowanych punktów
    % xmax – koniec przedziału całkowania [0, xmax]
    % ymax – górna granica wartości funkcji w przedziale [0, xmax]
    %        (musi spełniać warunek ymax ≥ max(f(x)))
    % integral_approximation – przybliżona wartość całki

    Nu = 0;
    Nl = 0;
    x = rand(1, N) * xmax;   % x w [0, xmax]
    y = rand(1, N) * ymax;   % y w [0, ymax]

    for i = 1:length(x)
        if y(i) > failure_density_function(x(i))
           Nu = Nu + 1;
        else
            Nl = Nl + 1;
        end
    end

    area = xmax * ymax;


    integral_approximation = (Nl/N)*area;
end


function ft = failure_density_function(t)
   
    ft = exp(1)^((-(t-10)^2)/(2*9))/(3*sqrt(2*pi));
end