function [x1, y1, x2, y2] = fzero_results()
% UWAGA: w tej funkcji nie należy wywoływać funkcji fzero, tan.
% x1 - miejsce zerowe funkcji tangens obliczone przez fzero dla x=4.5
% x2 - miejsce zerowe funkcji tangens obliczone przez fzero dla x=6
% y1 - wartość funkcji tan wyznaczona dla argumentu x1
% y2 - wartość funkcji tan wyznaczona dla argumentu x2

options = optimset('Display','iter');
x1 = fzero(@tan,4.5, options);
x2 = fzero(@tan,6.0, options);
y1 = tan(x1);
y2 = tan(x2);

end