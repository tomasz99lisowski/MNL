clear all
close all
format compact

vN = 1000:1000:8000;

[A,b,x,vec_time_direct] = benchmark_solve_direct(vN);
print('zadanie2.png','-dpng');