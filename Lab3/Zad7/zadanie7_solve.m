function [r_norms_d, r_norms_j, r_norms_gs] = zadanie7_solve()
data = load('filtr_dielektryczny.mat');
A = data.A;
b = data.b;
N = 20000;

r_norms_gs = [];
r_norms_j = [];
r_norms_d = [];
% direct method
[r_norms_direct, ~] = solve_direct(A, b);
r_norms_d = r_norms_direct;
% Jacobi method
[r_norms_jacobi, ~] = solve_Jacobi(A, b, N);
r_norms_j = r_norms_jacobi;
% Gauss-Seidel method
[r_norms_gs, ~] = solve_Gauss_Seidel(A, b, N);
r_norms_gs = r_norms_gs;

end