function [x, y, z, zmin, lake_volume] = compute_lake_volume_monte_carlo()
    % Wyznacza objętość jeziora metodą Monte Carlo.
    %
    % x/y/z - wektory wierszowe, które zawierają współrzędne x/y/z punktów
    %       wylosowanych w celu wyznaczenia przybliżonej objętości jeziora
    % zmin - minimalna dopuszczalna wartość współrzędnej z losowanych punktów
    % lake_volume - objętość jeziora wyznaczona metodą Monte Carlo

    N = 1e6;
    x = 100*rand(1,N); % [m]
    y = 100*rand(1,N); % [m]
    
    zmin = -50;
    z = zmin*rand(1, N);
    V = 100*100*50;
    N1 = 0;
    for i = 1:N
        zlake = get_lake_depth(x(i), y(i));
        if zlake > z(i)
            N1 = N1 + 1;
        end

    end



    lake_volume = (N1/N)*V;

end