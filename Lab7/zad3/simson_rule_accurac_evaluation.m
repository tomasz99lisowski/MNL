function [ft_5, integral_1000, Nt, integration_error] = simpson_rule_accuracy_evaluation()


    reference_value = 0.0473612919396179; % wartość wzorcowa całki

    ft_5 = failure_density_function(5);
    N = 1000; % liczba podprzedziałów całkowania
    x = linspace(0,5,N+1); % liczba punktów = liczba podprzedziałów całkowania + 1
    integral_1000 = simpson_rule(x);

    Nt = 5:50:10^4;
    for i = 1:length(Nt)
        N = Nt(i);
        x = linspace(0,5,N+1);
        val = simpson_rule(x);
        integration_error(1, i) = abs(val - reference_value);
    end

    loglog(Nt, integration_error);
    xlabel("Liczba przedziałów");
    ylabel("Błąd");
    legend("Liczba przedziałów", "Błąd");
    title("Metoda Simpsona");
    saveas(gcf, "zadanie3.png");
    


end

function integral_approximation = simpson_rule(x)
    result = 0;
    for i = 1:length(x)-1
        xi = x(i);
        x2 = x(i+1);
        dx = x2 - xi;

        result = result + (failure_density_function(xi) + 4*(failure_density_function((x2+xi)/2)) + failure_density_function(x2));
    end
    integral_approximation = result*(dx/6);
end


function ft = failure_density_function(t)
   
    ft = exp(1)^((-(t-10)^2)/(2*9))/(3*sqrt(2*pi));
end