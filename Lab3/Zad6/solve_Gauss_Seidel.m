function [A,b,U,T,w,x,r_norm,iteration_count] = solve_Gauss_Seidel()

% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% U - macierz trójkątna górna, która zawiera wszystkie elementy macierzy A powyżej głównej diagonalnej,
% T - macierz trójkątna dolna równa A-U
% w - wektor pomocniczy opisany w instrukcji do Laboratorium 3
%       – sprawdź wzór (7) w instrukcji, który definiuje w jako w_{GS}.
% x - rozwiązanie równania macierzowego
% r_norm - wektor norm residuum kolejnych przybliżeń rozwiązania; norm(A*x-b);
% iteration_count - liczba iteracji wymagana do wyznaczenia rozwiązania
%       metodą Gaussa-Seidla

N = 5001;

[A,b] = generate_matrix(N);

iteration_count = 0;
max_iter = 1000;
precision = 1e-12;

L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
T = (D+L);
M = -T\U;
w = T\b;

x = ones(N,1);
r_norm = [];
inorm = 1e22;
for i = 1:max_iter
    
    inorm = norm(A*x - b);
    x = M*x + w;
    iteration_count = i;
    if inorm < precision
        iteration_count = iteration_count - 1;
        r_norm = [r_norm; inorm];
        break;
    else
        r_norm = [r_norm; inorm];
    end
end

semilogy(r_norm);
title('Gauss Seidl solve');
xlabel('Iteration');
ylabel('Norm value');
r_norm = r_norm';
end